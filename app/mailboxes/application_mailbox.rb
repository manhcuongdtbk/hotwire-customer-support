class ApplicationMailbox < ActionMailbox::Base
  routing /^conversation-(\d+)@/i => :reply
  routing all: :conversation

  protected

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

  def body
    if mail.multipart?
      if mail.html_part
        mail.html_part.body.decoded
      elsif mail.text_part
        mail.text_part.body.decoded
      end
    else
      # Decoded email's body
      mail.decoded
    end
  end
end
