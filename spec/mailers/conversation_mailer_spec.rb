require 'rails_helper'

RSpec.describe ConversationMailer, type: :mailer do
  describe 'new_post' do
    let(:mail) { described_class.new_post }

    it 'renders the headers', :aggregate_failures do
      expect(mail.subject).to eq('New post')
      expect(mail.to).to eq(['to@example.org'])
      expect(mail.from).to eq(['from@example.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('Hi')
    end
  end
end
