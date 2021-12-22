FactoryBot.define do
  factory :post do
    conversation { nil }
    author { nil }
    message_id { 'MyString' }
    body { nil }
  end
end
