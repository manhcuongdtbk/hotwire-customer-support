require 'rails_helper'

RSpec.describe 'conversations/index', type: :view do
  before do
    assign(:conversations, [
             Conversation.create!(
               subject: 'Subject',
               contact: nil
             ),
             Conversation.create!(
               subject: 'Subject',
               contact: nil
             )
           ])
  end

  it 'renders a list of conversations' do
    render
    assert_select 'tr>td', text: 'Subject'.to_s, count: 2
    assert_select 'tr>td', text: nil.to_s, count: 2
  end
end
