class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])

  end

  def current_subscription
    @current_subscription ||= Subscription.find_by(id: session[:subscription_id])
  end

  def is_authenticated
    redirect_to login_url unless current_user
  end


protected

def admin?

if session[:user_id]	
  if current_user.role=="admin"
  	true
  else
	 flash[:error] = "unauthorized access"
   redirect_to root_url
  end
end

end

def authorize
  unless admin?
    flash[:error] = "unauthorized access"
    redirect_to root_url
    false
  end
end




end


