class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index

    @receiver_user = User.find(params[:user_id])

    @messages = []
    # binding.pry
    unless current_user.sent_messages.empty?
      @messages += current_user.sent_messages.where(receiver: @receiver_user)#.to_ary
    end
    unless @receiver_user.sent_messages.empty?
      @messages += @receiver_user.sent_messages.where(receiver: current_user)#.to_ary
    end
# binding.pry
    # @messages = current_user.sent_messages.where(receiver_id: @receiver.id) +
    #             @receiver_user.sent_messages.where(receiver_id: current_user.id)
    # # end

    @message = Message.new
    # @messages =  Message.private_messages_array(@receiver.id)

  end

  def new
  end

  def create
   # binding.pry
    @message = Message.new(message_params)
    # # @message.receiver_id = params[:receiver_id]
    # @message.sender_id = current_user.id
    @message.save
    redirect_to user_messages_path #(receiver_id: @message.receiver_id), method: :get

  end

  def destroy
    # binding.pry
    message = Message.find_by(sender_id: params[:user_id], id: params[:id])
    message.destroy
    redirect_to :back
  end

  # def update
  #   message = Message.find()
  #   message.destroy
  #   redirect_to :back
  # end

  private

  def message_params
    params.require(:message).permit(:body,:sender_id,:receiver_id)
  end

end
