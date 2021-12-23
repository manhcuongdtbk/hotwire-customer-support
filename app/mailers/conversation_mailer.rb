class ConversationMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.conversation_mailer.new_post.subject
  #

  # rubocop:disable Metrics/AbcSize
  def new_post
    @post = params[:post]
    @author = @post.author
    @conversation = params[:conversation]

    headers['In-Reply-To'] = params[:in_reply_to]
    headers['References'] = params[:references]

    mail(to: params[:to], reply_to: params[:reply_to], bcc: params[:bcc])
  end
  # rubocop:enable Metrics/AbcSize
end
