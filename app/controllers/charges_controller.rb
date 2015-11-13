class ChargesController < ApplicationController

before_action :require_buser, only: [:new, :create, :show, :index] 


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
	id=current_branduser.id 
	@charges=Charge.where(:branduser_id => id)
end



def create 
@charge=Charge.new(charge_params)
useremail=params[:useremail]
amount=params[:amount]
explanation=params[:charge][:explanation]
 

customer=Stripe::Customer.create(
	:email => params[:stripeEmail],
	:source => params[:stripeToken])

 if @charge.save
   	redirect_to charge_path(@charge)
   	end 

end 
   	def charge
charge=Stripe::Charge.create(

	:customer=>  customer.id, 
	:amount => "#{amount}" ,
	:description => "#{useremail}",
	:currency => 'usd',
	:metadata => "#{explanation}")
    

  

rescue Stripe::CardError => e 
	flash[:error]=e.message
	redirect_to new_charge_path
 

end 



def show
@charge=Charge.find_by_id(params[:id])
end 


 private 

def charge_params
    params.require(:charge).permit(:productname, :instalink, :instapost, :explanation, :status, :amount, :message, :branduser_id, :instauser_id)
  end 
       


 







end
