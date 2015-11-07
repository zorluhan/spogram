module InstausersHelper
	def current_instauser 
    @current_instauser ||= Instauser.find(session[:user_id]) if session[:user_id]
end


def require_user 
  redirect_to '/login' unless current_instauser 
end
end
