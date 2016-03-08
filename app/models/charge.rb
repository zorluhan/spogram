class Charge < ActiveRecord::Base
  include ActiveModel::Transitions

  belongs_to :instauser, dependent: :destroy
  belongs_to :branduser, dependent: :destroy

  after_create :send_new_proposal_email

  state_machine do
    state :pending # first one is initial state
    state :accepted
    state :declined
    state :release_requested
    state :completed

    event :accepted, success: :charge_accept_callback do
      transitions to: :accepted, from: [:pending]
    end
    event :declined, success: :charge_decline_callback do
      transitions to: :declined, from: [:pending]
    end
    event :release_requested, success: :charge_release_request_callback do
      transitions to: :release_requested, from: [:accepted]
    end
    event :completed, success: :charge_complete_callback do
      transitions to: :completed, from: [:release_requested]
    end
  end


  def edited_proposal_email
    ChargeMailer.delay.new_proposal_email(instauser_id, branduser_id, id)
    end 

  private
    def send_new_proposal_email
      ChargeMailer.delay.new_proposal_email(instauser_id, branduser_id, id)
    end
    


    def charge_accept_callback
      update_column(:is_read, false)
      ChargeMailer.delay.accepted_email(instauser_id, branduser_id, id)
    end

    def charge_decline_callback
      update_column(:is_read, false)
      ChargeMailer.delay.declined_email(instauser_id, branduser_id, id)
    end

    def charge_release_request_callback
      update_column(:is_read, false)
      ChargeMailer.delay.release_requested_email(instauser_id, branduser_id, id)
    end

    def charge_complete_callback
      update_column(:is_read, false)
      ChargeMailer.delay.completed_email(instauser_id, branduser_id, id)
    end
end
