class InstausersController < ApplicationController

  include InstausersHelper

before_action :require_user, only: [:dashboard]


		def auth
       
  		require 'instagram'
  		require 'sinatra'

  		Instagram.configure do |config|
  		config.client_id= "55b89c9652df4cd4b5249cada73369e9"
  		config.client_secret= "ce4fb9cd068c477d8fda40fc651b4449"
  
  		end 
 redirect_to Instagram.authorize_url(:redirect_uri => "http://localhost:3000/callback")
 
  		
 		end 

  					def callback 
             
   					response = Instagram.get_access_token(params[:code], :redirect_uri => "http://localhost:3000/callback")
  					session[:access_token] = response.access_token
  					 
  					 	@client = Instagram.client(:access_token => session[:access_token])
              
  					 	if Instauser.find_by_username(@client.user.username).nil?
  					 		redirect_to '/signup'
  					 
  					 	else
                @instauser=Instauser.find_by_username(@client.user.username)
  					 		session[:user_id]=@instauser.id
  					 		redirect_to "/dashboard"
   						end
   					end


def new 
	
    @instauser=Instauser.new
    redirect_to '/auth'

end 

def signup
@instauser=Instauser.new 
@client = Instagram.client(:access_token => session[:access_token])
  end 


  			def create
  			@client = Instagram.client(:access_token => session[:access_token])
  		    @instauser= Instauser.new(instauser_params) 
  		
  		 
  			if @instauser.save 
   			 session[:user_id] = @instauser.id 
   			 flash[:notice] = "Giriş Başarılıdır."
    		redirect_to '/dashboard' 
  			else 
   			 redirect_to '/signup' 
 			 end 
   
 

			end

def dashboard
	@client = Instagram.client(:access_token => session[:access_token])
	username=@client.user.username 
	@instauser=Instauser.find_by_username(username)

end 


private
  def instauser_params
    params.require(:instauser).permit(:age, :location, :email, :password, :username, :postprice, :theme)
  end

end



