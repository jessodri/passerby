class ConversationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_conversation, only: [:show, :edit, :update, :destroy]

  def index
    @conversations = Conversation.user_conversations(current_user)
  end

  def create
    pickup_request = PickupRequest.find_by_id(params[:pickup_request_id])
    sender = pickup_request.user
    
  if params[:receiver_id]!=sender.id # Sender and Receiver should not be the same

      if Conversation.between(params[:sender_id], params[:receiver_id]).present?
        @conversation = Conversation.between(params[:sender_id], params[:receiver_id]).first
      else
        @conversation = Conversation.create!(conversation_params)
      end

      redirect_to conversation_messages_path(@conversation)

  else
    respond_to do |format|
      format.html { redirect_to pickup_request_path(@pickup_request), notice: 'You cannot send a message to yourself.' }
      format.json { head :no_content }
    end

  end

  def update
    respond_to do |format|
      if @conversation.update(conversation_params)
        format.html { redirect_to @conversation, notice: 'Conversation was successfully updated.' }
        format.json { render :show, status: :ok, location: @conversation }
      else
        format.html { render :edit }
        format.json { render json: @conversation.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @conversation.destroy
    respond_to do |format|
      format.html { redirect_to conversations_url, notice: 'Conversation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def conversation_params
      params.permit(:sender_id, :receiver_id)
    end

    def set_conversation
      @conversation = Conversation.find(params[:id])
    end

end

end
