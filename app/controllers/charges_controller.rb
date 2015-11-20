class ChargesController < ApplicationController

 
before_action :require_buser, only: [:new, :create, :show] 
before_action :require_user, only: [:bill]
 
def new
@charge=Charge.new 
@instauser=Instauser.find_by_id(params[:instauser])
@amount= @instauser.postprice*100
@branduser=current_branduser
buserid=@branduser.id 
buser=@branduser.fullname
@message=@instauser.email 

end 

def index

	if branduser_logged_in? 
	id=current_branduser.id 
	@charges=Charge.where(:branduser_id => id)
elsif instauser_logged_in?
	id=current_instauser.id 
	@charges=Charge.where(:branduser_id => id)
else
	redirect_to root_path

end

end


def create 

@charge=Charge.new(charge_params)
useremail=params[:useremail]
amount=params[:amount]
explanation=params[:charge][:explanation]
 

customer=Stripe::Customer.create(
	:email => params[:stripeEmail],
	:source => params[:stripeToken],
	:description => "#{amount},#{useremail} , #{explanation}")

@charge.customer=customer.id 
@charge.useremail=useremail


 if @charge.save
   	redirect_to charge_path(@charge)
   	end 

end 


def bill

@charge= Charge.find_by_id(params[:charge])
amount=@charge.amount
customerid= @charge.customer  
useremail=@charge.useremail
explanation=@charge.explanation 


charge=Stripe::Charge.create(

	:customer=>  customerid, 
	:amount => "#{amount}" ,
	:description => "#{useremail}",
	:currency => 'usd')
    
 if charge["paid"] == true
 	@charge.status= "accepted"
 	@charge.save
 	redirect_to charges_path

 end



rescue Stripe::CardError => e 
	flash[:error]=e.message
	redirect_to charges_path

 
  
end 






def show
@charge=Charge.find_by_id(params[:id])
end 


 private 

def charge_params
    params.require(:charge).permit(:productname, :instalink, :instapost, :explanation, :status, :amount, :message, :branduser_id, :instauser_id)
  end 
       


 







end
