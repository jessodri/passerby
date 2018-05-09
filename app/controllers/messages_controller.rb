class MessagesController < ApplicationController
  # before_action :authenticate_user!
  # before_action :set_conversation

  before_action do
    @conversation = Conversation.find(params[:conversation_id])
   end

 def index
  @messages = @conversation.messages
   if @messages.length > 10
    @over_ten = true
    @messages = @messages[-10..-1]
   end
   if params[:m]
    @over_ten = false
    @messages = @conversation.messages
   end
  if @messages.last
   if @messages.last.user_id != current_user.id
    @messages.last.read = true;
   end
  end
 @message = @conversation.messages.new
  end

 def new
  @message = @conversation.messages.new
 end

#  def create
#   @message = @conversation.messages.new(message_params)
#   if @message.save
#    redirect_to conversation_messages_path(@conversation)
#   end
#  end

def create
  @message = @conversation.messages.new(message_params)
  @message.user = current_user

  if @message.save
    redirect_to conversation_messages_path(@conversation)
  end    
end
 private
  def message_params
   params.require(:message).permit(:body, :user_id)
  end

  # before_action do
  #   @conversation = Conversation.find(params[:conversation_id])
  # end

  # def index
  #   @messages = @conversation.messages.order(:created_at).last(10)
  #   if (current_user == @conversation.receiver) || (current_user == @conversation.sender)
  #     @message = @conversation.messages.new
  #   else
  #     redirect_to root_path
  #   end
  # end

  # def new
  #   @message = @conversation.messages.new
  # end


  # private
  #   def message_params
  #     params.require(:message).permit(:body, :user_id)
  #   end

  #   def set_conversation
  #     @conversation = Conversation.find(params[:conversation_id])
  #   end
end
