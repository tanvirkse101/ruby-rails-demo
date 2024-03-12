class CreateChats < ActiveRecord::Migration[7.0]
  def change
    create_table :chats do |t|
      t.text :text
      t.references :user, foreign_key: true, null: false
      t.references :group, foreign_key: true, null: false

      t.timestamps
    end
    add_index :chats, [:user_id, :group_id, :created_at]
  end
end
