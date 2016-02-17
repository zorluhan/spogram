class BrandusersController < ApplicationController

  include BrandusersHelper

  before_action :require_buser, only: [:dashboard]
  before_action :logged_in_branduser , only: [:edit, :update, :dashboard]
  before_action :correct_branduser , only: [:edit, :update, :dashboard]

  def new
     @branduser=Branduser.new 
  	end

  def create 
    @branduser= Branduser.new(branduser_params) 

    if @branduser.save 
      session[:buser_id] = @branduser.id 
      redirect_to '/bdashboard'
    else 
      flash!(:error => I18n.t("flash_messages.defaults.hata"))
      render 'new'
    end 
  end 

  def dashboard
    @branduser= Branduser.find_by_id(session[:buser_id])
    @instausers=Instauser.all 
  end

  def edit
    @branduser=Branduser.find_by_id(params[:id]) 
  end

  def update
    @branduser=Branduser.find_by_id(params[:id])
    if @branduser.update_attributes(branduser_params)
      flash!(:success => I18n.t("flash_messages.defaults.success"))
      redirect_to '/bdashboard'
    else
      flash!(:error => I18n.t("flash_messages.defaults.hata"))
      render 'edit'
    end
  end

  private
    def branduser_params
      params.require(:branduser).permit(:coname, :title, :comsize, :country, :phone, :firstname, :lastname, :cowebsite, :email, :password, :username, :image)
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

end
