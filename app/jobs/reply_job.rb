class ReplyJob < ApplicationJob
  attr_reader :post

  # rubocop:disable Metrics/MethodLength
  def perform(post)
    # The post was already sent out
    return if post.message_id?

    @post = post

    mail = ConversationMailer.with(
      to: 'noreply@example.com',
      reply_to: "conversation-#{post.conversation_id}@example.com",
      bcc: recipients.map { |recipient| "#{recipient.name} <#{recipient.email}>" },
      post: post,
      conversation: conversation,
      in_reply_to: previous_message_ids.last,
      references: previous_message_ids
    ).new_post.deliver_now

    post.update(message_id: mail.message_id)
  end
  # rubocop:enable Metrics/MethodLength

  private

  def conversation
    @conversation ||= post.conversation
  end

  def recipients
    @recipients ||= conversation.authors - [post.author]
  end

  def previous_message_ids
    @previous_message_ids ||= conversation.posts.where.not(id: post.id).pluck(:message_id).compact
  end
end
