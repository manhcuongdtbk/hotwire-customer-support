class ApplicationMailbox < ActionMailbox::Base
  routing /^conversation-(\d+)@/i => :reply
  routing all: :conversation

  attr_reader :attachments

  before_processing :save_attachments

  protected

  def save_attachments
    @attachments = mail.attachments.map do |attachment|
      blob = ActiveStorage::Blob.create_and_upload!(
        io: StringIO.new(attachment.body.to_s),
        filename: attachment.filename,
        content_type: attachment.content_type
      )

      { blob: blob, content_id: (attachment.content_id[1...-1] if attachment.content_id) }
    end
  end

  def from
    @from ||= mail[:from].address_list.addresses.first
  end

  def contact
    contact = Contact.where(email: from.address).first_or_initialize
    contact.update(name: from.display_name)
    contact
  end

  def author
    user = User.find_by(email: from.address)
    user.presence || contact
  end

  # rubocop:disable Metrics/AbcSize
  def process_html
    document = Nokogiri::HTML(mail.html_part.body.decoded)

    attachments.each do |attachment_hash|
      content_id = attachment_hash[:content_id]
      next unless content_id

      blob = attachment_hash[:blob]
      element = document.at_css "img[src='cid:#{content_id}']"
      # rubocop:disable Layout/LineLength
      element.replace "<action-text-attachment sgid=\"#{blob.attachable_sgid}\" content-type=\"#{blob.content_type}\" filename=\"#{blob.filename}\"></action-text-attachment>"
      # rubocop:enable Layout/LineLength
    end

    document.at_css('body').inner_html.encode('utf-8')
  end
  # rubocop:enable Metrics/AbcSize

  def body
    if mail.multipart?
      if mail.html_part
        process_html
      elsif mail.text_part
        mail.text_part.body.decoded
      end
    else
      # Decoded email's body
      mail.decoded
    end
  end
end
