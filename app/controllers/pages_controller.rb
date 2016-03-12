class PagesController < ApplicationController

  def secondhome
  end 

  def privacy
  end

  def home
  end

  def about 
  end

  def logout
  end 

def index3
end

def index4 
  end 

def faq
end

def index2
end
def index5
  end

 def terms
 end
 
  def search
  end
 
 def welcome 
 end
 
  
  def instagrammers
  end

  def instagramers
    redirect_to '/instagrammers'
  end 

  def myinstagram
    redirect_to '/instagrammers'
  end 

  def influencers
    redirect_to '/instagrammers'
  end 

  def results
    sleep 1
    @instausers=Instauser.where(location: "İstanbul")
  end

end
