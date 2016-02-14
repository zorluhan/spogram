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

    # redirect_to Instagram.authorize_url(:redirect_uri => "https://cryptic-mountain-3688.herokuapp.com/callback")
    redirect_to Instagram.authorize_url(:redirect_uri => "http://localhost:3000/callback")
  end 

  def callback 
    # response = Instagram.get_access_token(params[:code], :redirect_uri => "https://cryptic-mountain-3688.herokuapp.com/callback")
    response = Instagram.get_access_token(params[:code], :redirect_uri => "http://localhost:3000/callback")
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

    username=@client.user.username 
    @instauser=Instauser.find_by_username(username)

    response = @client.user_recent_media  
    album = [].concat(response)  
    max_id = response.pagination.next_max_id  

    while !(max_id.to_s.empty?) do  
      response = @client.user_recent_media(:max_id => max_id)  
      max_id = response.pagination.next_max_id 
      album.concat(response) 
    end  

    @album = album  

    #average likes and comments#

    a=0
    counter=0
    b=0 

    @album.each do |z|
      a=a+z.likes[:count] 
      b=b+z.comments[:count]
      counter=counter+1 
    end 

    @averagelikes= a/(counter.nonzero? || 1)
    @averagecomments=b/(counter.nonzero? || 1)
    @engagementscore='%.2f' % ((a+b)/(@client.user.counts.followed_by * counter*0.5)).to_f 
  end 

  def search
    @instausers=Instauser.where(:theme => params[:instauser][:theme]).where(:gender => params[:instauser][:gender]).where(:age => params[:instauser][:age1]..params[:instauser][:age2]).where("followed_by >=?", params[:instauser][:followed_by]).where("postprice <?", params[:instauser][:postprice]).where("averagelikes >=?", params[:instauser][:averagelikes])  if !params[:instauser].nil?
  end 

  def edit
    @instauser=Instauser.find_by_id(params[:id]) 

    states = CS.get(@instauser.country)
    @cities = []
    states.each do |state|
      @cities += CS.get(@instauser.country, state[0])
    end
    @cities = @cities.uniq.sort
  end

  def update
    @instauser=Instauser.find_by_id(params[:id])
    if @instauser.update_attributes(instauser_params)
      flash!(:success => I18n.t("flash_messages.defaults.success"))  
      redirect_to '/dashboard'
    else
      render 'edit'
    end
  end


  private
    def instauser_params
      params.require(:instauser).permit(
        :gender, :profile_picture, :recent_media_urls, :followed_by, :fullname, :country, :city, 
        :date_of_birth, :email, :username, :postprice, :theme, :averagelikes, :averagecomments )
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

