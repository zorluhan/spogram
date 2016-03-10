require 'elasticsearch/model'

class Instauser < ActiveRecord::Base

  has_many :messages, dependent: :destroy
  has_many :charges,  dependent: :destroy
  has_many :brandusers, through: :charges
  has_many :instaposts
 
 
  #validates :firstname, :presence => true 
  #validates :lastname, :presence => true 
 
  #include Elasticsearch::Model
  #include Elasticsearch::Model::Callbacks

  #serialize :recent_media_urls

  #after_create :send_welcome_email


  def send_welcome_email
    if Rails.env.production?
      if email.present?
        if followed_by >= 5000
          # to send emails in delayed jobs use
          # UserMailer.instauser_welcome_email(id).delay.deliver!
          UserMailer.instauser_welcome_email(id).deliver!
        else
          UserMailer.instauser_reject_email(id).deliver!
        end
      end
    end
  end


  def fetch_instagram_timeline
    if access_token.present?

      if last_updated.nil? or (Time.now - 2.minutes) > last_updated


        client = Instagram.client(:access_token => access_token)
        response = client.user_recent_media  
        recent_media = [].concat(response) 
        user_recent_media = [].concat(response)  
        max_id = response.pagination.next_max_id  
        i = 0
        while !(max_id.to_s.empty?) and i < 3 do  
          response = client.user_recent_media(:max_id => max_id)  
          max_id = response.pagination.next_max_id 
          user_recent_media.concat(response) 
          i = i + 1
        end

        #average likes and comments#
        a=0
        counter=0
        b=0 
        user_recent_media.each do |z|
          a=a+z.likes[:count] 
          b=b+z.comments[:count]
          counter=counter+1 
        end 
        averagelikes= a/(counter.nonzero? || 1)
        averagecomments=b/(counter.nonzero? || 1)

        engagementscore ='%.2f' % ((a+b)/(client.user.counts.followed_by * counter*0.5)).to_f 

        
        media_popular = user_recent_media.sort! { |a,b| a.likes[:count] <=> b.likes[:count] }



        #save user details
        self.update_attributes(:last_updated => Time.now,
                                :followed_by => client.user.counts.followed_by,
                                :averagelikes => averagelikes,
                                :averagecomments => averagecomments,
                                :engagementscore => engagementscore,
                                :profile_picture => client.user.profile_picture)
        

        # save user posts
        Instapost.where(:instauser_id => id).delete_all

         recent_media.first(8).each do |media|
          Instapost.create(:media_thumb_url => media.images.thumbnail.url, 
                           :media_standard_url => media.images.standard_resolution.url, 
                           :instauser_id => id,
                           :likes_counts => media.likes[:count])
        end

        media_popular.last(8).reverse!.each do |media|
          Instapost.create(:media_thumb_url => media.images.thumbnail.url, 
                           :media_standard_url => media.images.standard_resolution.url, 
                           :instauser_id => id,
                           :likes_counts => media.likes[:count],
                           :most_liked => true)
                            
        end
      end
    end
  end

 
    
end
