class ChargesController < ApplicationController

  before_action :require_buser, only: [:new, :create, :show] 
  before_action :require_user, only: [:bill]
  before_action :correct_user, only: [:bill]
  before_action :correct_user_for_show, only: [:show]

  def new
    @charge    = Charge.new 
    @instauser = Instauser.find_by_id(params[:instauser])
    @amount    = @instauser.postprice*100
    @branduser = current_branduser
    buserid    = @branduser.id 
    buser      = @branduser.fullname
    @message   = @instauser.email 
  end 

  def index
    if branduser_logged_in? 
      id = current_branduser.id 
      @charges = Charge.where(:branduser_id => id)
    elsif instauser_logged_in?
      id = current_instauser.id 
      @charges = Charge.where(:instauser_id => id)
      @earned  = 0
      @charges.each do |x|
        if x.accepted? 
          @earned = @earned + (x.amount/115).round
        end
      end
    else
      redirect_to root_path
    end
  end

  def list
    state = params[:state]
    if branduser_logged_in? 
      id = current_branduser.id 
      @charges = Charge.where(branduser_id: id).where(state: state)
    elsif instauser_logged_in?
      id = current_instauser.id 
      @charges = Charge.where(instauser_id: id).where(state: state)

      # mark the un-read charges as read
      @charges.where(is_read: false).update_all(is_read: true)
    else
     redirect_to root_path
    end
  end

  def create 
    @charge = Charge.new(charge_params)
    useremail   = params[:useremail]
    amount      = params[:amount]
    explanation = params[:charge][:explanation]

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source => params[:stripeToken],
      :description => "#{amount},#{useremail},#{explanation}")

    @charge.customer  = customer.id 
    @charge.useremail = useremail

    if @charge.save
      flash!(:success => I18n.t("flash_messages.defaults.payment_notify_branduser"))
      redirect_to charge_path(@charge)
    end 
  end 


  def accept
    @charge     = Charge.find_by_id(params[:id])
    amount      = @charge.amount
    customerid  = @charge.customer  
    useremail   = @charge.useremail
    explanation = @charge.explanation 

    if @charge.accepted?
      flash!(:error => I18n.t("flash_messages.defaults.recurring"))
      redirect_to root_path 
    else 
      charge=Stripe::Charge.create(
        :customer =>  "#{customerid}", 
        :amount   => "#{amount}" ,
        :description => "#{useremail}",
        :currency => 'usd')

      if charge["paid"] == true
        if @charge.accepted!
          flash!(:error => I18n.t("flash_messages.defaults.payment_notify_instauser")) 
          redirect_to charges_path
        else 
          flash!(:error => I18n.t("flash_messages.defaults.couldntgetbilled"))
          redirect_to root_path
        end 
      end
    end
  rescue Stripe::CardError => e 
    flash[:error]=e.message
    redirect_to charges_path
  end

  def decline
    @charge = Charge.find_by_id(params[:id])

    if @charge.declined!
      flash!(:error => "Proposal Declined") 
    else
      flash!(:error => "Cannot Decline Proposal") 
    end
    redirect_to charges_path
  end

  def release_request
    @charge = Charge.find_by_id(params[:id])

    if @charge.release_requested!
      flash!(:error => "Release Request sent") 
    else
      flash!(:error => "Cannot send release request") 
    end
    redirect_to charges_path
  end

  def complete
    @charge = Charge.find_by_id(params[:id])

    # pay instauser here
    if @charge.completed!
      flash!(:error => "Marked Complete") 
    else
      flash!(:error => "Cannot send mark complete") 
    end
    redirect_to charges_path
  end

  def show
    @charge = Charge.find_by_id(params[:id])
    if @charge.branduser_id != current_branduser.id
      redirect_to root_path
    end
  end 

  private 
    def charge_params
      params.require(:charge).permit(:productname, :instalink, :instapost, :explanation, :amount, :message, :branduser_id, :instauser_id)
    end 

    def correct_user
      if instauser_logged_in?
        @charge = current_instauser.charges.find_by_id(params[:charge])
        if @charge.nil?
          flash!(:error => I18n.t("flash_messages.defaults.sizeaitdegil"))
          redirect_to root_path
        end
      elsif branduser_logged_in?
      	@charge = current_branduser.charges.find_by_id(params[:charge])
        if @charge.nil?
          flash!(:error => I18n.t("flash_messages.defaults.sizeaitdegil"))
          redirect_to root_path
        end
      end
    end

    def correct_user_for_show
      if branduser_logged_in?
        @charge = current_branduser.charges.find_by_id(params[:id])
        if @charge.nil?
          flash!(:error => I18n.t("flash_messages.defaults.sizeaitdegil"))
          redirect_to root_path
        end
      end
    end
end
