class ConversationsController < ApplicationController
  before_action :set_conversation, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
    # @conversations = Conversation.all
    # @conversations = Conversation.user_conversations(current_user)

    @conversations = Conversation.where("sender_id = ? OR receiver_id = ?", current_user.id, current_user.id)
  end

  def create

    pickup_request = PickupRequest.find_by_id(params[:pickup_request_id])
    receiver = pickup_request.user
    puts "RECIEVER_ID: #{receiver.id}"
    puts "CURRENT_USER_ID: #{current_user.id}"
    
    if current_user.id != receiver.id # Sender and Receiver should not be the same

      if Conversation.between(current_user.id,receiver.id).length > 0
        puts "IN if"
        @conversations = Conversation.between(current_user.id,receiver.id)
        @conversation = @conversations.where(pickup_request_id: params[:pickup_request_id]).first

      else
        puts "IN else"
        conversation_init = {
                  sender: current_user,
                  receiver: receiver,
                  pickup_request: pickup_request
                }
        @conversation = Conversation.create!(conversation_init)
      end
      redirect_to conversation_messages_path(@conversation.id)

    else
          respond_to do |format|
            format.html { redirect_to pickup_request_path(@pickup_request), notice: 'You cannot send a message to yourself.' }
            format.json { head :no_content }
          end
    end

  end

  def show

  end

  def edit

  end

  def update

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
     params.permit(:sender_id, :receiver_id, :pickup_request_id)
    end

    def set_conversation
      @conversation = Conversation.find(params[:id])
    end

  # def update
  #   respond_to do |format|
  #     if @conversation.update(conversation_params)
  #       format.html { redirect_to @conversation, notice: 'Conversation was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @conversation }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @conversation.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

end

