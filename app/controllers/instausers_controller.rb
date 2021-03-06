class InstausersController < ApplicationController

  include InstausersHelper

  before_action :require_user, only: [:dashboard]
  before_action :require_buser, only: [:search]
  before_action :logged_in_instauser , only: [:edit, :update, :brands, :brands_contact_form, :destroy]
  before_action :correct_instauser , only: [:edit, :update]

  def auth   
    #redirect_to Instagram.authorize_url(:redirect_uri => "https://cryptic-mountain-3688.herokuapp.com/callback")
    redirect_to Instagram.authorize_url(:redirect_uri => INSTAGRAM_CALLBACK_URL)
  end 

  def callback 
    #response = Instagram.get_access_token(params[:code], :redirect_uri => "https://cryptic-mountain-3688.herokuapp.com/callback")
    response = Instagram.get_access_token(params[:code], :redirect_uri => INSTAGRAM_CALLBACK_URL)

    client = Instagram.client(:access_token => response.access_token)
   


  
 

    instauser = Instauser.find_by_username(client.user.username)
   

    if instauser.nil? or instauser.disabled
      if instauser.nil?
        instauser = Instauser.create(:access_token => response.access_token, 
                       :username => client.user.username,
                       :profile_picture => client.user.profile_picture,
                       :followed_by => 0)
      end
      reset_session
      session[:instauser_id] = nil 
      set_cache_buster
      session[:instauser_id] = instauser.id
      redirect_to '/signup'
     else
      instauser.update_attributes(:access_token => response.access_token,
                                  :profile_picture => client.user.profile_picture)
      reset_session
      instauser_log_in(instauser)
      redirect_to "/dashboard"
      end

 
  
  end

  def new 
    
    redirect_to '/auth'
  end 

  def signup
    instauser = Instauser.find_by_id(session[:instauser_id])
     
    if  instauser.nil?
        session[:instauser_id]= nil
        reset_session
        flash!(:error => "You are not allowed to do that!")  
        redirect_to "/pages/logout"
    else

    # fetch timelines of user in background using Sidekiq (bundle exec sidekiq)
    SnsFeedsWorker.perform_in(2.seconds, instauser.id)

  end

  end 

  def create
    @instauser= Instauser.find_by_id(session[:instauser_id])
    if @instauser.update(instauser_params)
      session[:instauser_id] = nil
      instauser_log_in(@instauser)
      @instauser.send_welcome_email
      redirect_to "/dashboard"
    else

      render "signup"
    end
  end

def brands_contact_form

end 



  def dashboard
    @instauser = current_instauser
    @instauser_recent_posts = @instauser.instaposts.where(:most_liked => false).order("created_at DESC")
    @instauser_most_liked_posts = @instauser.instaposts.where(:most_liked => true).order("likes_counts DESC")
    # fetch timelines of user in background using Sidekiq (bundle exec sidekiq)
    SnsFeedsWorker.perform_async(@instauser.id)
  end

  def search
   #@instausers=Instauser.where(:theme => params[:instauser][:theme]).where(:gender => params[:instauser][:gender]).where(:age => params[:instauser][:age1]..params[:instauser][:age2]).where("followed_by >=?", params[:instauser][:followed_by]).where("postprice <?", params[:instauser][:postprice]).where("averagelikes >=?", params[:instauser][:averagelikes]).where(:disabled=> false)  if !params[:instauser].nil?  

if params[:instauser][:username] != ""
    username=params[:instauser][:username].downcase 
    @instausers=Instauser.where(:disabled => false).where(:username => username)

elsif params[:instauser][:username]=""

    if params[:instauser][:theme]=="Passion"
        flash!(:error => "Please select a passion")  
        redirect_to "/bdashboard"
    else


          if params[:instauser][:followed_by]=="" 

              if params[:instauser][:gender]=="Gender"

                  @instausers=Instauser.where(:disabled => false).where(:theme => params[:instauser][:theme])

              else

                 @instausers=Instauser.where(:disabled => false).where(:theme => params[:instauser][:theme]).where(:gender => params[:instauser][:gender])  

              end 
   
 #redirect_to "/bdashboard"
          elsif !(params[:instauser][:followed_by].to_i.to_s==params[:instauser][:followed_by])
               flash!(:error => "Please enter a number")  
              redirect_to "/bdashboard"

          else
               if params[:instauser][:gender]=="Gender"

                   @instausers=Instauser.where(:theme => params[:instauser][:theme]).where("followed_by >=?", params[:instauser][:followed_by])

               else

                @instausers=Instauser.where(:theme => params[:instauser][:theme]).where("followed_by >=?", params[:instauser][:followed_by]).where(:gender=> params[:instauser][:gender])
                end 

   


#@instausers=Instauser.where(:disabled => false).where((theme = ? OR followed_by = ? ) OR gender = ? , params[:instauser][:theme], params[:instauser][:followed_by], params[:instauser][:gender])

          end
    end
end
 
end

  def edit
    @instauser=Instauser.find_by_id(params[:id])
     @maximum_length = 300

  end

    def editaccount
    @instauser=Instauser.find_by_id(params[:id])
  end

  def update    
    @instauser=Instauser.find_by_id(params[:id])
    if instauser_params[:send_email].present?
      params[:instauser][:send_email] = instauser_params[:send_email].to_s == 'checked-value' ? true : false
    end
    if @instauser.update(instauser_params)
      flash_now!(:success => I18n.t("flash_messages.defaults.youraccountupdated"))  
      redirect_to '/dashboard'
    else
      render 'edit'
    end
  end

  def brands 
  end 

  def brands_contact_form
    respond_to do |format|
        format.html
        format.js
    end
  end



def formmessage
end

 def destroy
    @instauser=Instauser.find(params[:id])
    @instauser.disabled= true 
    if @instauser.save

    redirect_to "/pages/logout" 
  end
end

  private

  def instauser_params
    params.require(:instauser).permit(
      :gender, :profile_picture, :recent_media_urls, :followed_by, :location, :dob,
      :date_of_birth, :email, :media_date, :bio, :checkvalidation, :username, :postprice, :firstname, :lastname, :theme, :averagelikes, :averagecomments, :disabled, :paypal_email, :send_email )
  end 

  def logged_in_instauser
    unless instauser_logged_in?
      flash!(:notloggedin)
      redirect_to "/pages/logout"
    end
  end

  def correct_instauser
    @instauser = Instauser.find_by_id(params[:id])      
    redirect_to root_path unless @instauser==current_instauser 
  end

end

