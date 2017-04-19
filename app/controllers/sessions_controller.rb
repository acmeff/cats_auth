class SessionsController < ApplicationController
  before_action :logged_in?, only: [:new]
  
  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:username], params[:user][:password])
    if @user
      login!(@user)
      redirect_to cats_url
    else
      flash[:errors] = ["Incorrect credentials"]
      render :new
    end
  end

  def destroy
    if current_user
      current_user.reset_session_token!
      session[:session_token] = nil
    end
    redirect_to new_sessions_url
  end

end
