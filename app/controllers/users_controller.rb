class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def create
    @user = User.new(user_params)
    if @user.save
      reset_session # session fixation
      log_in(@user)
      
      flash[:success] = 'Welcome to the Sample App Developed By Bagaja Birhanu!'
      redirect_to @user
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def new
    @user = User.new
  end

  def show; end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation)
  end
end
