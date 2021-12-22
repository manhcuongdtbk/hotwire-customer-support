class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.references :conversation, null: false, foreign_key: true
      t.references :author, polymorphic: true, null: false
      t.string :message_id

      t.timestamps
    end
  end
end
