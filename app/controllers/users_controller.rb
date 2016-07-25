class UsersController < ApplicationController

    before_action :authenticate_user!

  def index
    @users = User.all#.page(params[:page]).per(10)
  end

  def show
    # binding.pry
    @user = User.find(params[:id])

  end

end
