class Contact < ApplicationRecord
  has_many :posts, as: :author, dependent: :nullify
  has_many :conversations, dependent: :nullify
end
