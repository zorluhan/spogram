module MessagesHelper

  def unread_conversation_count current_user
    current_user.messages.group(:branduser_id).where(is_read: false).count.count
  end

  def unread_messages_count instauser, branduser
    instauser.messages.where(branduser_id: branduser.id, is_read: false).count
  end
end
