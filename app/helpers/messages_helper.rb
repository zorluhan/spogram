module MessagesHelper

  def instauser_unread_total_messages_count current_user
    current_user.messages.where(is_read: false, sender: 0).count
  end

  def branduser_unread_total_messages_count current_user
    current_user.messages.where(is_read: false, sender: 1).count
  end

  def unread_instauser_messages_count instauser, branduser
    instauser.messages.where(branduser_id: branduser.id, is_read: false, sender: 0).count
  end

  def unread_branduser_messages_count branduser, instauser
    branduser.messages.where(instauser_id: instauser.id, is_read: false, sender: 1).count
  end
end
