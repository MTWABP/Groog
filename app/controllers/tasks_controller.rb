class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group
  before_action :set_task, only: [:show, :edit, :update, :destroy, :create_comment]

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = @group.tasks
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = @group.tasks.build(task_params)
    @task.owner_id = current_user.id
    @task.group_id = @group.id

    respond_to do |format|
      if @task.save
        format.html { redirect_to group_task_path(@group.slug, @task), notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to group_task_path(@group.slug, @task), notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to group_tasks_path, notice: 'Task was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def create_comment
    @comment = @task.comments.build(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      Pusher.trigger(@task.class.to_s+'-'+@task.id.to_s, 'new-comment', @comment.as_json(include: :user))
      render json: @comment.as_json(include: :user)
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = @group.tasks.find(params[:id])
    end

    def set_group
      @group = Group.find_by_slug(params[:group_slug])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:task, :description, :due_date, :assignee_id)
    end

    def comment_params
      params.require(:comment).permit(:body)
    end
end
