module BrandusersHelper

	def current_branduser 
 	@current_branduser ||= Branduser.find(session[:user_id]) if session[:user_id]
 	end

 	
def require_buser
	redirect_to '/blogin' unless current_branduser 
end
end
