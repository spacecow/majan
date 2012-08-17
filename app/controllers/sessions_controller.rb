class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_userid(params[:login])
    user = User.find_by_email(params[:login]) if user.nil?
    if user && user.authenticate(params[:password])
      session_userid(User.last.id)
      flash[:notice] = notify(:logged_in)
      if url = session_original_url
        session_original_url(nil)
        redirect_to url and return
      end
      redirect_to root_url
    else
      flash.now.alert = alertify(:invalid_login_or_password)
      render :new
    end
  end

  def destroy
    session_userid(nil)
    redirect_to root_url, notice:notify(:logged_out)
  end
end
