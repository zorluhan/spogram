class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
 	
  helper_method :current_instauser 
  helper_method :current_branduser 

def current_instauser 
	
    @current_instauser ||= Instauser.find(session[:user_id]) if session[:user_id]
end
 	
 	def current_branduser 
 	@current_branduser ||= Branduser.find(session[:user_id]) if session[:user_id]
 	end

def require_user 
  redirect_to '/login' unless current_instauser 
end

def require_buser
	redirect_to '/blogin' unless current_branduser 
end

end
