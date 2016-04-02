class PagesController < ApplicationController

  
  def privacy
  end

  def home
  end

  def about 
  end

  def logout
  end 

  def logout2
  end 

 
def verification
end

def testmarketing
end 

  def brandwaitlist
  end

def faq
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
