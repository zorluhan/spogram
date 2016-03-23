class BrandusersController < ApplicationController

  include BrandusersHelper

  before_action :require_buser, only: [:dashboard]
  before_action :logged_in_branduser , only: [:edit, :update, :dashboard]
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
      flash!(success: "Please check your email for account verification")
      redirect_to "/pages/brandwaitlist"
    else 
      flash!(error: I18n.t("flash_messages.defaults.hata"))
      render 'new'
    end 
  end 

  def dashboard
    @branduser= Branduser.find_by_id(session[:buser_id])
    @instausers=Instauser.where(:disabled=>false).order("followed_by ASC").take(12)

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
      flash!(error: I18n.t("flash_messages.defaults.hata"))
      render 'edit'
    end
  end

  def authenticate
    @branduser = Branduser.find_by(auth_token: params[:token])
    @branduser.is_authenticated = true
    @branduser.auth_token = nil
    if @branduser.save
      flash!(success: "Email verified")
      branduser_log_in(@branduser)
      redirect_to bdashboard_path(id: @branduser.id)
    else
      flash!(error: "Token invalid")
      redirect_to root_path
    end
  end

  private
    def branduser_params
      params.require(:branduser).permit(:coname, :title, :comsize, :country, :phone, :firstname, :lastname, :cowebsite, :email, :password,  :image)
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
