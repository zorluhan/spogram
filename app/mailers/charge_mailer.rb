class ChargeMailer < ActionMailer::Base
  default from: "Capish <mail@capish.co>"

  def new_proposal_email(instauser_id, branduser_id, charge_id)
    @instauser = Instauser.find_by(id: instauser_id)
    @branduser = Branduser.find_by(id: branduser_id)
    @charge    = Charge.find_by(id: charge_id)

    mail(to: @instauser.email, subject: "You have received a new proposal from #{@branduser.coname}")
  end

  def accepted_email(instauser_id, branduser_id, charge_id)
    @instauser = Instauser.find_by(id: instauser_id)
    @branduser = Branduser.find_by(id: branduser_id)
    @charge    = Charge.find_by(id: charge_id)

    mail(to: @branduser.email, subject: "Proposal Accepted by #{@instauser.firstname}")
  end

  def declined_email(instauser_id, branduser_id, charge_id)
    @instauser = Instauser.find_by(id: instauser_id)
    @branduser = Branduser.find_by(id: branduser_id)
    @charge    = Charge.find_by(id: charge_id)

    mail(to: @branduser.email, subject: "Proposal Declined by #{@instauser.firstname}")
  end


  def edited_proposal_email(instauser_id, branduser_id, charge_id)
    @instauser = Instauser.find_by(id: instauser_id)
    @branduser = Branduser.find_by(id: branduser_id)
    @charge    = Charge.find_by(id: charge_id)

    mail(to: @instauser.email, subject: "Your proposal id #{@charge.id} has been edited by #{@branduser.coname}")
  end 


  def release_requested_email(instauser_id, branduser_id, charge_id)
    @instauser = Instauser.find_by(id: instauser_id)
    @branduser = Branduser.find_by(id: branduser_id)
    @charge    = Charge.find_by(id: charge_id)

    mail(to: @branduser.email, subject: "Release Requested by #{@instauser.firstname}")
  end

  def completed_email(instauser_id, branduser_id, charge_id)
    @instauser = Instauser.find_by(id: instauser_id)
    @branduser = Branduser.find_by(id: branduser_id)
    @charge    = Charge.find_by(id: charge_id)

    mail(to: @instauser.email, subject: "Proposal Completed by #{@branduser.coname}")
  end
end
