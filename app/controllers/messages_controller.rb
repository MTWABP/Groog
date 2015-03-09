class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group
  before_action :set_message, only: [:destroy]

  # GET /messages
  # GET /messages.json
  def index
    @messages = @group.messages
	
  end

  # POST /messages
  # POST /messages.json
  def create
	@message = @group.messages.build(message_params)
	@message.channel_type = "Group"
	@message.channel_id = @group.id
	@message.user_id = current_user.id
	
	if @message.save
		Pusher.trigger('private-'+@group.class.to_s+'-'+@group.slug, 'new-message', @message.as_json(include: :user))
		render json: @message
	else 
		render json: @message.errors
	end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
	render json: "{hello: 'world'}"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:body)
    end
	
	def set_group
      @group = Group.find_by_slug(params[:group_slug])
    end
end
