class BrandusersController < ApplicationController

  include BrandusersHelper

before_action :require_buser, only: [:dashboard]

	def new
    @branduser=Branduser.new 
	end


	def create 
		@branduser= Branduser.new(branduser_params) 

  			if @branduser.save 
   			 session[:buser_id] = @branduser.id 
    		redirect_to '/bdashboard'
  			else 
         flash!(:error)

   			 redirect_to '/bsignup'
 			 end 
	end 


 def dashboard
 	@branduser= Branduser.find_by_id(session[:buser_id])
  @instausers=Instauser.all 


def search
@instausers=Instauser.where(age: :age)

end 



 end

  private
  def branduser_params
    params.require(:branduser).permit(:coname, :country, :phone, :fullname, :cowebsite, :email, :password, :username, :image)
  end
end
