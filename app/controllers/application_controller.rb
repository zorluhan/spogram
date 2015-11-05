class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
 	
 helper_method :current_instauser 

def current_instauser 
	@client = Instagram.client(:access_token => session[:access_token])
    @current_instauser ||= Instauser.find_by_username(@client.user.username)  
end
 	
def require_user 
  redirect_to '/login' unless current_instauser 
end



end
