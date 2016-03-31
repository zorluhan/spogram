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
    
    if client.user.username == "hassanplz" or client.user.username == "zorluhan2" or client.user.username == "meikaash" or client.user.username == "zorluhan2017" or client.user.username == "sahikasss" or client.user.username == "melihsahinkaya" or client.user.username == "opprette" or client.user.username == "tanemsivar" or  client.user.username == "vlad.bomboe" or  client.user.username == "cagrierdogdu"  or  client.user.username == "savasmazer" or client.user.username == "nilperi" or  client.user.username == "denizmarsan" or client.user.username == "edhem" or client.user.username == "aysekucuroglu" or client.user.username == "eliffkaradayi" or client.user.username == "eliffkaradayi" or client.user.username == "ardaonen" or client.user.username == "maritsanbul"  or client.user.username == "cizenbayan" or client.user.username == "rukendemirer" or client.user.username == "mervetoy" or client.user.username == "ebru_ekmekci" or client.user.username== "zorluhanzor.lu" or client.user.username == "maritsanbul"  or client.user.username == "ahmet.erdem" or client.user.username == "sert_mehmet" or client.user.username == "nineteen0seven" or client.user.username == "iremguzey" or client.user.username=="nihankayalioglu" or client.user.username == "ancienm" or client.user.username == "isingormus" or client.user.username == "yunusemreakkor" or  client.user.username == "cabukcan" or client.user.username == "admbrs" or client.user.username == "kemalilter" or  client.user.username == "citiesthatwork" or  client.user.username == "ojemrujumrimelim"  or  client.user.username == "damlamu" or client.user.username == "oanatache" or client.user.username == "wolejkowolejszo" or client.user.username == "zorluhanzor.lu" or client.user.username == "johnbiggs"  or client.user.username == "sozyitimii" or client.user.username == "socialmomm" or client.user.username == "bebisfoto" or client.user.username == "dilanbozyel" or client.user.username == "baharakinci" or client.user.username == "fcosmos" or client.user.username == "berilbayindir" or client.user.username == "sengulpalli" or  client.user.username == "cemkiziltug" or client.user.username == "oyaunustasi" or client.user.username == "murattavliofficial" or  client.user.username == "unimetre" or client.user.username == "mezederyasi" or client.user.username == "tansuoskay"  or client.user.username == "parisrehberi" or client.user.username == "ig_kilikya" or client.user.username == "Alisveriscianne" or client.user.username == "melistosun" or client.user.username == "Asliguvenc" or client.user.username == "sonmastori" or client.user.username == "Tatdelisi"  or client.user.username == "Schi" or client.user.username == "piuevents" or client.user.username == "nilii" or client.user.username == "serrahanim" or client.user.username == "a_verona" or client.user.username == "Leyla_erdogan" or client.user.username == "erhansevenn" or client.user.username == "erhansevenn" or client.user.username == "billursaatci"

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

  else 
  redirect_to "/pages/logout2"
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
    @instauser_recent_posts = @instauser.instaposts.where(:most_liked => false)
    @instauser_most_liked_posts = @instauser.instaposts.where(:most_liked => true).order("likes_counts DESC")
    # fetch timelines of user in background using Sidekiq (bundle exec sidekiq)
    SnsFeedsWorker.perform_async(@instauser.id)
  end

  def search
   #@instausers=Instauser.where(:theme => params[:instauser][:theme]).where(:gender => params[:instauser][:gender]).where(:age => params[:instauser][:age1]..params[:instauser][:age2]).where("followed_by >=?", params[:instauser][:followed_by]).where("postprice <?", params[:instauser][:postprice]).where("averagelikes >=?", params[:instauser][:averagelikes]).where(:disabled=> false)  if !params[:instauser].nil?  

if params[:instauser][:username] != ""

@instausers=Instauser.where(:disabled => false).where(:username => params[:instauser][:username])

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
    Instauser.find(params[:id]).destroy
    redirect_to "/pages/logout" 
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

