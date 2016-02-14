class Charge < ActiveRecord::Base
  belongs_to :instauser
  belongs_to :branduser

  after_create :send_new_proposal_email

  private
    def send_new_proposal_email
# UserMailer.send_new_proposal_email(instauser_id, branduser_id, id).deliver!
    end
end
