class SessionsController < ApplicationController

	def new 
		@client = Instagram.client(:access_token => session[:access_token])
		@instauser

	end 

	def create 
		@branduser=Branduser.find_by_email([params[:session][:email]])
		if @branduser && @branduser.authenticate(params[:session][:password])
			session[:user_id]=@branduser.id 
			redirect_to '/bdashboard'
		else
			redirect_to '/blogin'
		end
	end 


	def destroy 

	 @instauser=nil
			session.delete(:user_id)
			@branduser=nil
					redirect_to '/pages/logout'
  



	end 
end
