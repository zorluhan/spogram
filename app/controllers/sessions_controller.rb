class SessionsController < ApplicationController

  def new
  end 

  def create 
    @branduser = Branduser.find_by_email([params[:session][:email]])
    if @branduser && @branduser.authenticate(params[:session][:password])
      if @branduser.is_authenticated
        branduser_log_in(@branduser) 
        redirect_to bdashboard_path(id: @branduser.id)
      else
        flash_now!(error: "You need to authenticate your account before login"))
        render 'new'
      end
    else
      flash_now!(error: I18n.t("flash_messages.defaults.youarenotauser"))
      render 'new'
    end
  end 

  def destroy
    @current_instauser = nil
    session.delete(:user_id)
    session.delete(:buser_id)
    session[:user_id]  = nil
    session[:buser_id] = nil
    @current_branduser = nil
    flash!(success: I18n.t("flash_messages.defaults.Loggedout"))
    redirect_to "/pages/logout"
  end 
end
