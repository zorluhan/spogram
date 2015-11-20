class MessagesController < ApplicationController



	def new 

	if branduser_logged_in? 
        @instauser_id= params[:instauser_param]  unless params[:instauser_param].nil? 
        @instauser=Instauser.find_by_id(@instauser_id)
        @profile_picture=@instauser.profile_picture
        @branduser_id= current_branduser.id
        @sender=0
    elsif instauser_logged_in?
        @branduser_id=params[:branduser_param]  unless params[:branduser_param].nil? 
        @instauser_id=current_instauser.id 
        @branduser=Branduser.find_by_id(@branduser_id)
        @sender=1
    else redirect_to root_path 
	end 
		@message=Message.new 
	end

def create

@message=Message.new(message_params)

if current_branduser
	@message.sender=0

	elsif current_instauser
		@message.sender=1

	else redirect_to root_path
end 

if @message.save 
	redirect_to messages_path
	 
end 


end 


def index

	if current_branduser 
		@id=current_branduser.id 
		@messages=Message.where(:branduser_id => @id)
 	
 	elsif current_instauser 
        @id=current_instauser.id
 		@messages=Message.where(:instauser_id => @id)
 
 	end



end 


private

 def message_params
    params.require(:message).permit(:message, :instauser_id, :branduser_id, :sender)
 end 


end