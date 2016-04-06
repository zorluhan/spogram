class BrandusersController < ApplicationController

  include BrandusersHelper

  before_action :require_buser, only: [:dashboard]
  before_action :logged_in_branduser , only: [:edit, :update, :dashboard, :profile]
  before_action :correct_branduser , only: [:edit, :update]

  def new
    reset_session
    @branduser=Branduser.new 
  end

  def create 
    @branduser = Branduser.new(branduser_params)
    @branduser.auth_token = generate_access_token
    if @branduser.save 
      # branduser_log_in(@branduser) # don't login on create
      
      redirect_to "/pages/verification"
    else 
      render 'new'
    end 
  end 

  def dashboard

    @branduser= Branduser.find_by_id(session[:buser_id])
    @instausers=Instauser.where(:disabled=>false).order("followed_by DESC").take(4)
    @featured=Instauser.where("username = ? OR  username= ?", "tanemsivar", "cagrierdogdu").order("followed_by DESC")
    @all= Instauser.all.where(:disabled=>false)
  end

  def edit
    @branduser=Branduser.find_by_id(params[:id]) 
  end

  def update
    @branduser=Branduser.find_by_id(params[:id])
    if @branduser.update(branduser_params)
      flash!(success: I18n.t("flash_messages.defaults.youraccountupdated"))
      redirect_to bdashboard_path(id: @branduser.id)
    else
      render 'edit'
    end
  end

  def authenticate
    @branduser = Branduser.find_by_auth_token(params[:token])
    @branduser.is_authenticated = true
    @branduser.auth_token = nil

    if @branduser.save
      flash!(success: "Email verified")
      branduser_log_in(@branduser)
      redirect_to bdashboard_path(id: @branduser.id)
    else
      flash!(error: "Token invalid")
      redirect_to '/pages/verification'
    end
    
  end


  def profile
    @instauser = Instauser.find_by_id(params[:id])
    SnsFeedsWorker.perform_in(@instauser.id)
    @instauser_recent_posts = @instauser.instaposts.where(:most_liked => false).order("created_at ASC")
    @instauser_most_liked_posts = @instauser.instaposts.where(:most_liked => true).order("likes_counts DESC")
    # fetch timelines of user in background using Sidekiq (bundle exec sidekiq)
    SnsFeedsWorker.perform_async(@instauser.id)


  end


  private
    def branduser_params
      params.require(:branduser).permit(:coname, :auth_token, :is_authenticated, :title, :comsize, :country, :phone, :firstname, :lastname, :cowebsite, :email, :password,  :image)
    end

    def logged_in_branduser
      unless branduser_logged_in?
        flash!(:error => I18n.t("flash_messages.defaults.notloggedin"))
        redirect_to root_path
      end
    end

    def correct_branduser
      @branduser = Branduser.find_by_id(params[:id])
      redirect_to root_path unless @branduser==current_branduser 
    end

    def generate_access_token
      loop do
        token = Devise.friendly_token
        break token unless Branduser.where(auth_token: token).first
      end
    end

end
