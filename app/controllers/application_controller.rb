class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :instauser_log_in
  helper_method :instauser_logged_in?
  helper_method :branduser_log_in
  helper_method :branduser_logged_in?
  helper_method :require_user 	
  helper_method :require_buser
  helper_method :current_instauser
  helper_method :current_branduser
 

  before_filter :set_cache_buster

  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

  def current_instauser
    if session[:user_id]  
      @current_instauser ||= Instauser.find_by_id(session[:user_id]) 
    end
  end 

 

  def require_anyuser
    redirect_to root_path unless current_instauser or current_branduser 
  end 

  def require_user 
  	redirect_to login_path unless current_instauser  
  end

  def current_branduser 
    @current_branduser ||= Branduser.find_by_id(session[:buser_id]) if session[:buser_id]
  end

  def require_buser
    redirect_to blogin_path unless current_branduser 
  end

  def instauser_log_in(user)
    session[:user_id] = user.id
  end

  def branduser_log_in(buser)
    session[:buser_id]= buser.id
  end

  def instauser_logged_in?
    !current_instauser.nil?
  end

  def branduser_logged_in?
    !current_branduser.nil?
  end

  def reset_session
    session[:buser_id] = nil
    session[:user_id] = nil
  end

end
