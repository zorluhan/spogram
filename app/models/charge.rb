class Charge < ActiveRecord::Base
  belongs_to :instauser, dependent: :destroy
  belongs_to :branduser, dependent: :destroy

  after_create :send_new_proposal_email

  private
    def send_new_proposal_email
      UserMailer.send_new_proposal_email(instauser_id, branduser_id, id).deliver!
    end
end
