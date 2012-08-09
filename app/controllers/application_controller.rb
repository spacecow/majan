class ApplicationController < ActionController::Base
  include BasicApplicationController
  protect_from_forgery

  helper_method :pl, :jt, :mess, :current_user

  rescue_from CanCan::AccessDenied do |exception|
    exception.default_message = alertify(:unauthorized_access)
    flash[:alert] = exception.message
    if current_user
      redirect_to welcome_url
    else
      session[:original_url] = request.path  
      redirect_to login_url
    end
  end
end
