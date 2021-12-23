class Conversation < ApplicationRecord
  has_many :posts, dependent: :destroy

  belongs_to :contact

  broadcasts_to ->(_conversation) { 'conversations' }, inserts_by: :prepend, target: 'conversations'

  def authors
    posts.includes(:author).map(&:author).uniq
  end
end
