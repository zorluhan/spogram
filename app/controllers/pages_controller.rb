class PagesController < ApplicationController

 

def home 
 
end


def about  
end

def logout
end 

def search
end

 def form
 end
  
	 


def results
	sleep 1
@instausers=Instauser.where(location: "İstanbul")
end


end
