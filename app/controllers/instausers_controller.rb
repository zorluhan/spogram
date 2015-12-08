class InstausersController < ApplicationController

  include InstausersHelper

before_action :require_user, only: [:dashboard]
before_action :require_buser, only: [:search]
before_action :logged_in_instauser , only: [:edit, :update]
before_action :correct_instauser , only: [:edit, :update]

		def auth
       
  		Instagram.configure do |config|
  		config.client_id= "55b89c9652df4cd4b5249cada73369e9"
  		config.client_secret= "ce4fb9cd068c477d8fda40fc651b4449"
      end 
      

      redirect_to Instagram.authorize_url(:redirect_uri => "https://cryptic-mountain-3688.herokuapp.com//callback")
 
  		
 		  end 

  					def callback 
             
   					response = Instagram.get_access_token(params[:code], :redirect_uri => "https://cryptic-mountain-3688.herokuapp.com//callback")
  					 
            session[:access_token] = response.access_token
  					@client = Instagram.client(:access_token => session[:access_token])
              
  					 	if Instauser.find_by_username(@client.user.username).nil?
  					 		redirect_to '/signup'
  					 
  					 	else
                @instauser=Instauser.find_by_username(@client.user.username)
                @instauser.profile_picture=@client.user.profile_picture
                 if @instauser.save
                    session[:user_id]=@instauser.id
                end
                
  				      
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

  # if @client.user.counts.followed_by<10000 
  #  redirect_to root_path
 #   flash!(:refused)
#  else

	username=@client.user.username 
	@instauser=Instauser.find_by_username(username)

# end

end 

def search


@instausers=Instauser.where(:gender => params[:instauser][:gender]).where(:age => params[:instauser][:age1]..params[:instauser][:age2]).where("followed_by >?", params[:instauser][:followed_by]).where("postprice <?", params[:instauser][:postprice]).where("averagelikes >?", params[:instauser][:averagelikes])  if !params[:instauser].nil?
 
 end 


def edit
@instauser=Instauser.find_by_id(params[:id]) 
end

def update
  @instauser=Instauser.find_by_id(params[:id])
  if @instauser.update_attributes(instauser_params)
      flash!(:success)
      redirect_to '/dashboard'
  else
    render 'edit'
  end
end



private
  def instauser_params
    params.require(:instauser).permit(:gender, :profile_picture, :recent_media_urls, :followed_by, :fullname, :age, :location, :email, :password, :username, :postprice, :theme, :averagelikes, :averagecomments )
  end 
       
       def logged_in_instauser
        unless instauser_logged_in?
          flash!(:notloggedin)
          redirect_to root_path
       end
       end

      def correct_instauser
      @instauser = Instauser.find_by_id(params[:id])

      redirect_to root_path unless @instauser==current_instauser 
      end
       


end

