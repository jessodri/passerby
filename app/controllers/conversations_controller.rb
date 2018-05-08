class ConversationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_conversation, only: [:show, :edit, :update, :destroy]

  def index
    puts "IN INDEX"
    puts @conversation
    # @conversations = Conversation.user_conversations(current_user)
    @conversations = Conversation.where("sender_id = ? OR receiver_id = ?", current_user.id, current_user.id)

  end

  def create
    puts "IN CREATE"
    puts params
    pickup_request = PickupRequest.find_by_id(params[:pickup_request_id])
    receiver = pickup_request.user
    
    if current_user.id != receiver.id # Sender and Receiver should not be the same

      if Conversation.between(params[:sender_id], params[:receiver_id]).present?
        puts "IF TRUE"
        @conversation = Conversation.between(params[:sender_id], params[:receiver_id]).first
      else
        puts "IF FALSE" 
        conversation_init = {
          sender_id: current_user.id,
          receiver_id: receiver.id,
          pickup_request: pickup_request
        }
        @conversation = Conversation.create!(conversation_init)
      end

      redirect_to conversation_messages_path(@conversation)

    else
      respond_to do |format|
        format.html { redirect_to pickup_request_path(@pickup_request), notice: 'You cannot send a message to yourself.' }
        format.json { head :no_content }
      end
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

