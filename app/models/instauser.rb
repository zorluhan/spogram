require 'elasticsearch/model'

class Instauser < ActiveRecord::Base

  has_many :messages
  has_many :charges 
  has_many :brandusers, through: :charges

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  serialize :recent_media_urls

  after_create :send_welcome_email


  private
    def send_welcome_email
      if followed_by >= 5000
        # to send emails in delayed jobs use
        # UserMailer.instauser_welcome_email(id).delay.deliver!
        UserMailer.instauser_welcome_email(id).deliver!
      else
        UserMailer.instauser_reject_email(id).deliver!
      end
    end
end
