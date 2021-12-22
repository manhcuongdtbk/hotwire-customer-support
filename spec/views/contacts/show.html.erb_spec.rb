require 'rails_helper'

RSpec.describe 'contacts/show', type: :view do
  before do
    @contact = assign(:contact, Contact.create!(
                                  name: 'Name',
                                  email: 'Email'
                                ))
  end

  it 'renders attributes in <p>', :aggregate_failures do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Email/)
  end
end
