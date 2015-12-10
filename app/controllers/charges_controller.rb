class ChargesController < ApplicationController

 
before_action :require_buser, only: [:new, :create, :show] 
before_action :require_user, only: [:bill]
before_action :correct_user, only: [:bill]
before_action :correct_user_for_show, only: [:show]

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
	@charges=Charge.where(:instauser_id => id)
	@earned=0
	@charges.each do |x|
		if x.status=="accepted" 
			@earned=@earned+curent_instauser.postprice 
		end
	end 


else
	redirect_to root_path

end

end


def publish_proposal

    if branduser_logged_in? 
	id=current_branduser.id 
	status=params[:status]
	@charges=Charge.where(:branduser_id => id).where(:status => status)


elsif instauser_logged_in?
	id=current_instauser.id 
	status=params[:status]
	@charges=Charge.where(:instauser_id => id).where(:status => status)

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
	:description => "#{amount},#{useremail},#{explanation}")

@charge.customer=customer.id 
@charge.useremail=useremail


 if @charge.save
 	flash!(:payment_notify_branduser)
   	redirect_to charge_path(@charge)
   	end 

end 


def bill

@charge= Charge.find_by_id(params[:charge])
amount=@charge.amount
customerid= @charge.customer  
useremail=@charge.useremail
explanation=@charge.explanation 

if @charge.status=="accepted"
	flash!(:recurring)
	redirect_to root_path 
else 

charge=Stripe::Charge.create(

	:customer=>  "#{customerid}", 
	:amount => "#{amount}" ,
	:description => "#{useremail}",
	:currency => 'usd')
 


 if charge["paid"] == true
 	@charge.status= "accepted"
 	 if @charge.save
 	   	flash!(:payment_notify_instauser)
	    redirect_to charges_path
	  

 	 else 
 			flash!(:couldntgetbilled)
 			redirect_to root_path

     end 
  end

end 

rescue Stripe::CardError => e 
	flash[:error]=e.message
	redirect_to charges_path

 
  
 
 end


 




def show
@charge=Charge.find_by_id(params[:id])
if @charge.branduser_id!=current_branduser.id
	redirect_to root_path
end

end 


 private 

def charge_params
    params.require(:charge).permit(:productname, :instalink, :instapost, :explanation, :status, :amount, :message, :branduser_id, :instauser_id)
  end 
       


 def correct_user
 	if instauser_logged_in?
      @charge = current_instauser.charges.find_by_id(params[:charge])
       if @charge.nil?
        flash!(:sizeaitdegil)
       	redirect_to root_path

    	end
  elsif branduser_logged_in?
  	@charge = current_branduser.charges.find_by_id(params[:charge])
  	 if @charge.nil?
  	  flash!(:sizeaitdegil)
  	  redirect_to root_path
  	  end

  	end
    
    end


def correct_user_for_show

	if branduser_logged_in?
		@charge=current_branduser.charges.find_by_id(params[:id])
		if @charge.nil?
			flash!(:sizeaitdegil)
			redirect_to root_path
		end
	end
end






end
