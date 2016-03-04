class SessionsController < ApplicationController

  before_action :requires_logged_out, only: [:new, :create]

  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(session_params[:username],
                                     session_params[:password])
    if @user
      login!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = ["User could not be found."]
      render :new
    end
  end

  def destroy
    @user = current_user
    logout!(@user)
    render :new
  end

  private

  def session_params
    params.require(:user).permit(:username, :password)
  end

end
