module MessagesHelper

  def total_unread_messages_count current_user
    current_user.messages.where(is_read: false, sender: 0).count
  end

  def unread_messages_count instauser, branduser
    instauser.messages.where(branduser_id: branduser.id, is_read: false, sender: 0).count
  end
end
