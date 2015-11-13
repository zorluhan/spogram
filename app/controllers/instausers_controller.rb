class InstausersController < ApplicationController

  include InstausersHelper

before_action :require_user, only: [:dashboard]
before_action :require_buser, only: [:search]


		def auth
       

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
  			 
  		  @instauser= Instauser.new(instauser_params) 
  		
  		 
  			if @instauser.save 
   			instauser_log_in(@instauser)
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

def search


@instausers=Instauser.where(:age => params[:instauser][:age1]..params[:instauser][:age2]).where("followed_by >?", params[:instauser][:followed_by]).where("postprice <?", params[:instauser][:postprice]).where("averagelikes >?", params[:instauser][:averagelikes])  if !params[:instauser].nil?
 
 end 


private
  def instauser_params
    params.require(:instauser).permit(:profile_picture, :recent_media_urls, :followed_by, :fullname, :age, :location, :email, :password, :username, :postprice, :theme, :averagelikes, :averagecomments )
  end 
       
       


end

