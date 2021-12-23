class ReplyMailbox < ApplicationMailbox
  MATCHER = /^conversation-(\d+)@/i

  def process
    conversation.posts.create(author: author, body: body, message_id: mail.message_id)
  end

  def conversation_id
    mail.recipients.each do |recipient|
      break Regexp.last_match(1) if ReplyMailbox::MATCHER.match(recipient).present?
    end
  end

  def conversation
    Conversation.find(conversation_id)
  end
end
