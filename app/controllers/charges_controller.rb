class ChargesController < ApplicationController

  before_action :require_buser, only: [:new, :create, :show] 
  before_action :require_user, only: [:accept]
  before_action :correct_user, only: [:accept, :detail]
  before_action :correct_user_for_show, only: [:show]

  def new
    @charge    = Charge.new 
    @instauser = Instauser.find_by_id(params[:instauser])
    # @amount    = @instauser.postprice*100
    @branduser = current_branduser
    buserid    = @branduser.id 
    buser      = @branduser.fullname
    @message   = @instauser.email 
  end 

  def edit
    @charge    = Charge.find_by_id(params[:id])
    @instauser = @charge.instauser
    # @amount    = @instauser.postprice*100
    @branduser = current_branduser

    unless @charge.pending? && branduser_logged_in? 
      redirect_to charges_path
    end
  end

  def index
    if branduser_logged_in? 
      @charges            = current_branduser.charges 
      @escrowed_spending = current_branduser.escrowed_spending
      @total_spending = current_branduser.total_spending
       @actual_spending = current_branduser.actual_spending
    elsif instauser_logged_in?
      @charges            = current_instauser.charges
      @pendingcharges     = current_instauser.charges.where(state: "pending")
      @potential_earnings = current_instauser.potential_earnings
      @upcomming_eatnings = current_instauser.upcomming_eatnings
      @total_earnings     = current_instauser.total_earnings
    else
      redirect_to root_path
    end
  end

  def list
    state = params[:state]
    if branduser_logged_in? 
      @charges            = current_branduser.charges.where(state: state)
      @escrowed_spending = current_branduser.escrowed_spending
      @total_spending = current_branduser.total_spending
       @actual_spending = current_branduser.actual_spending
      if ['accepted', 'declined', 'release_requested'].include? state
        @charges.where(state: state, is_read: false).update_all(is_read: true)
      end
    elsif instauser_logged_in?
      @charges            = current_instauser.charges.where(state: state)
      @potential_earnings = current_instauser.potential_earnings
      @upcomming_eatnings = current_instauser.upcomming_eatnings
      @total_earnings     = current_instauser.total_earnings
      if ['pending', 'completed'].include? state
        @charges.where(state: state, is_read: false).update_all(is_read: true)
      end
    else
     redirect_to root_path
    end
  end


def detail
id= params[:id]
 @charge = Charge.find_by_id(params[:id])
 @branduser= Branduser.find_by_id(@charge.branduser_id)
 @instauser= Instauser.find_by_id(@charge.instauser_id)

end 



  def create 

    useremail   = params[:useremail]
    # amount = params[:charge][:amount].to_i * 120  
    # params[:charge][:amount]= amount
    
    @charge = Charge.new(charge_params)
    
    # customer = Stripe::Customer.create(
    #   :email => params[:stripeEmail],
    #   :source => params[:stripeToken],
    #   :description => "#{amount},#{useremail}")
   

    # @charge.customer  = customer.id 
    @charge.useremail = useremail
   
    if @charge.save
       
      redirect_to charge_path(@charge)
    end 
  end 

  def update
    # amount = params[:charge][:amount].to_i
    # params[:charge][:amount] = amount * 1.20 * 100
     @charge = Charge.find_by_id(params[:id])
    if @charge.pending? && branduser_logged_in? 
      if @charge.update(charge_params)
        @charge.edited_proposal_email
        flash!(:success => "Proposal updated")
      else
        flash!(:error => "Error updating")
      end
    end
    redirect_to charges_path
  end

  def accept
    @charge     = Charge.find_by_id(params[:id])
    amount      = @charge.amount
    customerid  = @charge.customer  
    useremail   = @charge.useremail
 
    if @charge.accepted?
      flash!(:error => I18n.t("flash_messages.defaults.recurring"))
      redirect_to root_path 
    else 
      # charge=Stripe::Charge.create(
      #   :customer =>  "#{customerid}", 
      #   :amount   => "#{amount}" ,
      #   :description => "#{useremail}",
      #   :currency => 'usd')

      # if charge["paid"] == true
        if @charge.accepted!
          flash!(:alert => I18n.t("flash_messages.defaults.payment_notify_instauser")) 
          redirect_to charges_path
        else 
          flash!(:error => I18n.t("flash_messages.defaults.couldntgetbilled"))
          redirect_to charges_path
        end 
      # end
    end
  rescue Stripe::CardError => e 
    flash[:error]=e.message
    redirect_to charges_path
  end

  def decline
    @charge = Charge.find_by_id(params[:id])

    if @charge.declined!
      flash!(:success => "Proposal Declined") 
    else
      flash!(:error => "Cannot Decline Proposal") 
    end
    redirect_to charges_path
  end

  def release_request
    @charge = Charge.find_by_id(params[:id])

    if @charge.release_requested!
      flash!(:success => "Release Request sent") 
    else
      flash!(:error => "Cannot send release request") 
    end
    redirect_to charges_path
  end

  def complete
    @charge = Charge.find_by_id(params[:id])

    # pay instauser here
    if @charge.completed!
      flash!(:success => "Marked Complete") 
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
      params.require(:charge).permit(:product_name, :product_link, :product_description, :post_description, :suggested_caption, :hash_tags, 
        :user_names, :earliest_post_date, :last_post_date, :instagram_link, :amount, :message, :branduser_id, :instauser_id)
    end 

    def correct_user
      if instauser_logged_in?
        @charge = current_instauser.charges.find_by_id(params[:id])
        if @charge.nil?
          flash!(:error => I18n.t("flash_messages.defaults.sizeaitdegil"))
          redirect_to root_path
        end
      elsif branduser_logged_in?
      	@charge = current_branduser.charges.find_by_id(params[:id])
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
