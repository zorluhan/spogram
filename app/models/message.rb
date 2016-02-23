class Message < ActiveRecord::Base

  belongs_to :instauser, dependent: :destroy
  belongs_to :branduser, dependent: :destroy

  after_create :send_email

  private
    def send_email
      if sender == 0
        UserMailer.new_message_from_branduser_email(instauser_id, branduser_id, id).deliver!
      end
    end
end
