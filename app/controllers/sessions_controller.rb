class SessionsController < ApplicationController
  def create
    @user = User.find_by_email(params[:session][:email].downcase)
    if @user&.authenticate(params[:session][:password])
      forwarding_url = session[:forwarding_url]
      reset_session
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      log_in @user
      redirect_to forwarding_url || @user
    else
      # Create an error message.
      flash.now[:danger] = 'Invalid email/password combination.'
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    log_out
    flash.now[:success] = 'Logged out successfully.'
    redirect_to root_url, status: :see_other
  end

  def new; end
end
