class ConversationMailbox < ApplicationMailbox
  def process
    conversation = Conversation.create(subject: mail.subject, contact: contact)
    # If a post is failed to be created, an exception will be raised and the process job will be retried
    conversation.post.create!(author: contact, body: body, message_id: mail.message_id)
  end
end
