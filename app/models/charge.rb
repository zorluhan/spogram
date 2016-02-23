class Charge < ActiveRecord::Base
  include ActiveModel::Transitions

  belongs_to :instauser
  belongs_to :branduser

  after_create :send_new_proposal_email

  state_machine do
    state :pending # first one is initial state
    state :accepted
    state :declined
    state :completed

    event :accepted, success: :notify_accepted_email do
      transitions to: :accepted, from: [:pending]#, on_transition: :do_something
    end
    event :declined, success: :notify_declined_email do
      transitions to: :declined, from: [:pending]
    end
    event :completed, success: :notify_completed_email do
      transitions to: :accepted, from: [:accepted]#, guard: lambda { |charge| charge.complet? }
    end
  end

  private
    def send_new_proposal_email
      puts 'sending new proposal email'
      ChargeMailer.new_proposal_email(instauser_id, branduser_id, id).deliver!
    end

    def notify_accepted_email
      puts 'sending accepted email'
      ChargeMailer.accepted_email(instauser_id, branduser_id, id).deliver!
    end

    def notify_declined_email
      puts 'sending declined email'
      ChargeMailer.declined_email(instauser_id, branduser_id, id).deliver!
    end

    def notify_completed_email
      puts 'sending completed email'
      ChargeMailer.completed_email(instauser_id, branduser_id, id).deliver!
    end
end
