module ChargesHelper

  def instauser_total_unread_charges_count current_instauser
    current_instauser.charges.where(is_read: false, state: [:pending, :completed]).count
  end

  def branduser_total_unread_charges_count current_instauser
    current_instauser.charges.where(is_read: false, state: [:accepted, :declined, :release_requested]).count
  end


  def unread_charges_count current_instauser
    current_instauser.charges.where(is_read: false, state: :pending).count
  end

  def completed_charges_count current_instauser
    current_instauser.charges.where(is_read: false, state: :completed).count
  end

  def unread_branduser_charges_count current_branduser, state
    count = current_branduser.charges.where(is_read: false, state: state).count
    count > 0 ? "(#{count})" : ""
  end
end
