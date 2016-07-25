class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index

    @receiver_user = User.find(params[:user_id])

    # @messages = []#.page(params[:page])
    # binding.pry
    # unless current_user.sent_messages.empty?
    #   @messages += current_user.sent_messages.where(receiver: @receiver_user)#.to_ary
    # end
    # unless @receiver_user.sent_messages.empty?
    #   @messages += @receiver_user.sent_messages.where(receiver: current_user)#.to_ary
    # end
    messages_current_user = Message.where(sender_id: current_user.id,
                              receiver_id: @receiver_user.id)
    messages_current_receiver = Message.where(sender_id: @receiver_user.id,
                              receiver_id: current_user.id)
    # binding.pry
    @messages = (messages_current_user + messages_current_receiver).sort
    # binding.pry
    @messages = Kaminari.paginate_array(@messages).page(params[:page])
# binding.pry
    # @messages = current_user.sent_messages.where(receiver_id: @receiver.id) +
    #             @receiver_user.sent_messages.where(receiver_id: current_user.id)
    # # end
    # @messages = @messages.page(params[:page])


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
