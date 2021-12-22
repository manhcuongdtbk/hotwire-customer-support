require 'rails_helper'

RSpec.describe 'conversations/show', type: :view do
  before do
    @conversation = assign(:conversation, Conversation.create!(
                                            subject: 'Subject',
                                            contact: nil
                                          ))
  end

  it 'renders attributes in <p>', :aggregate_failures do
    render
    expect(rendered).to match(/Subject/)
    expect(rendered).to match(//)
  end
end
