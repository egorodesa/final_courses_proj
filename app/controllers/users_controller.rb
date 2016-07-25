class UsersController < ApplicationController

    before_action :authenticate_user!

  def index
    # @users = User.all#.page(params[:page]).per(10)
    # binding.pry
    if params[:search]
      @users = User.search(params[:search])
    else
      @users = User.all
    end
  end

  def show
    # binding.pry
    @user = User.find(params[:id])

  end

end
