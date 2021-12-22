class CreateConversations < ActiveRecord::Migration[7.0]
  def change
    create_table :conversations do |t|
      t.string :subject
      t.references :contact, null: false, foreign_key: true

      t.timestamps
    end
  end
end
