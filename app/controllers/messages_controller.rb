class MessagesController < ApplicationController

  before_action :require_anyuser 
  before_action :correct_user, only:[:show, :edit, :update]

  def new 
    if branduser_logged_in? 
      @instauser_id = params[:instauser_param] unless params[:instauser_param].nil? 
      @instauser = Instauser.find_by_id(@instauser_id)
      @profile_picture = @instauser.profile_picture
      @branduser_id = current_branduser.id
      @sender = 0
    elsif instauser_logged_in?
      @branduser_id = params[:branduser_param] unless params[:branduser_param].nil? 
      @instauser_id = current_instauser.id 
      @branduser = Branduser.find_by_id(@branduser_id)
      @sender = 1
    else 
      redirect_to root_path 
    end 
    @message = Message.new 
  end

  def create
    @message = Message.new(message_params)

    if current_branduser
      @message.sender = 0
    elsif current_instauser
      @message.sender = 1
    else 
      redirect_to root_path
    end 

    respond_to do |format|
      if @message.save 
        format.html{
          flash!(:email_success)
          redirect_to messages_path
        }
        format.js{
          redirect_to list_messages_path(branduser_id: params[:message][:branduser_id], instauser_id: params[:message][:instauser_id])
        }
      end 
    end
  end 

  def show
  end

  def edit
  end

  def index
    if current_branduser
      @id = current_branduser.id 
      @messages = Message.where(branduser_id: @id)
      instauserids = Message.where(branduser_id: @id).uniq.pluck(:instauser_id)
      @instausers = Instauser.where(id: instauserids)
    elsif current_instauser 
      @id = current_instauser.id
      @messages = Message.where(instauser_id: @id)
      branduserids = Message.where(instauser_id: @id).uniq.pluck(:branduser_id)
      @brandusers = Branduser.where(id: branduserids)
    end
  end 

  def list 
    if current_instauser 
      @branduser = Branduser.find_by_id(params[:branduser_id])
      @messagess  = Message.where(branduser_id: @branduser.id, instauser_id: current_instauser.id).order("created_at DESC")
      @messages.where(is_read: false, sender: 0).update_all(is_read: true)
    elsif current_branduser 
      @instauser = Instauser.find_by_id(params[:instauser_id])
      @messages = Message.where(instauser_id: @instauser.id, branduser_id: current_branduser.id).order("created_at DESC")
      @messages.where(is_read: false, sender: 1).update_all(is_read: true)
    end
  end

  private
    def message_params
      params.require(:message).permit(:message, :instauser_id, :branduser_id, :sender)
    end 

    def correct_user 
      if instauser_logged_in?
        @message = current_instauser.messages.find_by_id(params[:id])
        if @message.nil?
          flash!(:sizeaitdegil)
          redirect_to root_path
        end
      elsif branduser_logged_in?
        @message= current_branduser.messages.find_by_id(params[:id])
        if @message.nil?
          flash!(:sizeaitdegil)
          redirect_to root_path
        end
      end
    end
end
