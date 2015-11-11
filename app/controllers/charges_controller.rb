class ChargesController < ApplicationController

before_action :require_buser, only: [:new, :create]

def new
@instauser=Instauser.find_by_id(params[:instauser])
@amount= @instauser.postprice*100
@branduser=current_branduser
buserid=@branduser.id 
buser=@branduser.fullname
@message=@instauser.email 

end 



def create 

message=params[:message]
amount=params[:amount]
email=params[:email]

customer=Stripe::Customer.create(
	:email => params[:stripeEmail],
	:source => params[:stripeToken])



charge=Stripe::Charge.create(

	:customer=>  customer.id, 
	:amount => "#{amount}" ,
	:description => "#{message}",
	:currency => 'usd')



rescue Stripe::CardError => e 
	flash[:error]=e.message
	redirect_to new_charge_path

end 

 
 







end
