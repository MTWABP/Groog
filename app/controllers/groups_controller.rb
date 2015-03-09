class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: [:show, :edit, :update, :destroy, :join, :create_membership, :activate_membership, :invite]
  rescue_from Pundit::NotAuthorizedError, with: :user_not_active

  # GET /groups
  # GET /groups.json
  def index
    @groups = policy_scope(Group).includes(:tasks)
    @inactive = current_user.groups.inactive
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    authorize @group
  end

  # GET /groups/new
  def new
    @group = Group.new
    authorize @group
  end

  # GET /groups/1/edit
  def edit
    authorize @group
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(group_params)
    authorize @group

    respond_to do |format|
      if @group.save
        GroupMembership.create(user: current_user, group: @group, active: true)
        format.html { redirect_to group_path(@group.slug), notice: 'Group was successfully created.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    authorize @group
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to group_path(@group.slug), notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  # def destroy
  #   @group.destroy
  #   respond_to do |format|
  #     format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  # GET /groups/1/join
  # GET /groups/1/join.json
  def join
    authorize @group
    membership = GroupMembership.find_by(user: current_user, group: @group)
    if membership.nil?
      #render page normally
    elsif membership.active
      redirect_to group_path(@group.slug), notice: "You are already part of this team!"
    else
      redirect_to groups_path, notice: "Your membership is already pending for this group."
    end
  end

  # POST /groups/1/join
  # POST /groups/1/join.json
  def create_membership
    authorize @group
    membership = GroupMembership.find_by(user: current_user, group: @group)
    if membership.nil?
      GroupMembership.create(user: current_user, group: @group, active: false)
    elsif membership.active
      redirect_to group_path(@group.slug), notice: "You are already part of this team!"
    end
    redirect_to groups_path, notice: "This group has been notified of your request. Please wait to be activated."
  end

  # POST /groups/1/join/1
  # POST /groups/1/join/1.json
  def activate_membership
    authorize @group
    user = User.find(params[:user_id])
    membership = GroupMembership.find_by(user: user, group: @group)
    membership.active = true
    membership.save
    redirect_to group_path(@group.slug), notice: "#{user} has been activated."
  end

  # POST /groups/activate/1
  # POST /groups/activate/1.json
  def activate_invitation
    invitation = Invite.find(params[:id])
    if invitation.nil?
      redirect_to grouops_path, alert: "This invite is invalid. Sorry."
      return
    end
    group = Group.find(invitation.group.id)
    authorize group
    membership = GroupMembership.find_or_create_by(user: current_user, group: group)
    membership.active = true
    if membership.save
      invitation.destroy
      redirect_to group_path(group.slug), notice: "You are now a member of this group."
    else
      redirect_to groups_path, alert: "Something went wrong."
    end
  end
  
  # POST /groups/1/invite
  def invite
    invitees = params[:invites].split(/\r?\n/)
    invitees.each do |email|
      invite = @group.invites.build
      invite.save
      InviteMailer.invite_email(email, invite, @group, current_user).deliver_now
    end
    redirect_to group_path(@group.slug), notice: "Invites were successfully sent."
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_group
    @group = Group.find_by_slug(params[:slug])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def group_params
    params.require(:group).permit(:name, :description)
  end

  def user_not_active
    redirect_to join_group_path(@group.slug), notice: "You must request to join this group."
  end
end
