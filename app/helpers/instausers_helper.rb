module InstausersHelper

  def unread_charges_count current_instauser
    current_instauser.charges.where(is_read: false).count
  end
end
