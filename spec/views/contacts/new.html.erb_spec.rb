require 'rails_helper'

RSpec.describe 'contacts/new', type: :view do
  before do
    assign(:contact, Contact.new(
                       name: 'MyString',
                       email: 'MyString'
                     ))
  end

  it 'renders new contact form' do
    render

    assert_select 'form[action=?][method=?]', contacts_path, 'post' do
      assert_select 'input[name=?]', 'contact[name]'

      assert_select 'input[name=?]', 'contact[email]'
    end
  end
end
