class OmniauthCallbacksController < Devise::OmniauthCallbacksController

	# skip_before_filter :authenticate_user!

	def linkedin
		begin
			auth_params = request.env["omniauth.auth"]
			user = Branduser.from_omniauth(auth_params)
			if user.persisted?
	      branduser_log_in(user)
	      redirect_to "/bdashboard"
			else
	      flash!(:error => "Something wrong with create brand user")
	      redirect_to '/blogin'
			end
		rescue Exception => e
			flash!(:error => "Something wrong with create brand user #{e.message}")
			redirect_to '/blogin'
		end
	end

end
