require 'elasticsearch/model'

class Instauser < ActiveRecord::Base

  has_many :messages
  has_many :charges 
  has_many :brandusers, through: :charges
  has_many :instaposts

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  serialize :recent_media_urls

  after_create :send_welcome_email

  def fetch_instagram_timeline
    if access_token.present?

      if last_updated.nil? or (Time.now - 15.minutes) > last_updated


        client = Instagram.client(:access_token => access_token)
        response = client.user_recent_media  
        user_recent_media = [].concat(response)  
        max_id = response.pagination.next_max_id  
        while !(max_id.to_s.empty?) do  
          response = client.user_recent_media(:max_id => max_id)  
          max_id = response.pagination.next_max_id 
          user_recent_media.concat(response) 
        end

        # response = client.media_popular
        # media_popular = [].concat(response)  
        # max_id = response.pagination.next_max_id  
        # while !(max_id.to_s.empty?) do  
        #   response = client.media_popular(:max_id => max_id)  
        #   max_id = response.pagination.next_max_id 
        #   media_popular.concat(response) 
        # end        
        

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



        #save user details
        self.update_attributes(:last_updated => Time.now,
                                :followed_by => client.user.counts.followed_by,
                                :averagelikes => averagelikes,
                                :averagecomments => averagecomments,
                                :engagementscore => engagementscore,
                                :profile_picture => client.user.profile_picture)
        

        # save user posts
        instaposts.delete_all

        user_recent_media.first(8).each do |media|
          Instapost.create(:media_thumb_url => media.images.thumbnail.url, 
                           :media_standard_url => media.images.standard_resolution.url, 
                           :instauser_id => id)
        end

        user_recent_media.first(8).each do |media|
          Instapost.create(:media_thumb_url => media.images.thumbnail.url, 
                           :media_standard_url => media.images.standard_resolution.url, 
                           :instauser_id => id,
                           :most_liked => true)
        end
      end
    end
  end


  private
    def send_welcome_email
      if Rails.env.production?
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
