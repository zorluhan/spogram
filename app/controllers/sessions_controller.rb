class SessionsController < ApplicationController

	def new 
		
	end 

	def create 

		@branduser=Branduser.find_by_email([params[:session][:email]])
		if @branduser && @branduser.authenticate(params[:session][:password])
			branduser_log_in(@branduser) 
			
			redirect_to bdashboard_path(id: @branduser.id)
		else
			redirect_to '/blogin'
		end
	end 


	def destroy 
 
	 		@current_instauser=nil
			session.delete(:user_id)
			session.delete(:buser_id)
			session[:user_id]=nil
			session[:buser_id]=nil
			@current_branduser=nil
			redirect_to '/pages/logout'
  



	end 
end
