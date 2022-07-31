class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:username])

    if user.present? && user.authenticate(params[:password])
      login user
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    logout
    redirect_to sign_in_path
  end
end
