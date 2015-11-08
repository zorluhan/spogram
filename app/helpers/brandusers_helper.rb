module BrandusersHelper

	def current_branduser 
 	@current_branduser ||= Branduser.find(session[:buser_id]) if session[:buser_id]
 	end


def require_buser
	redirect_to blogin_path unless current_branduser 
end
end
