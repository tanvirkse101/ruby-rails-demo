class CreateNotices < ActiveRecord::Migration[7.0]
  def change
    create_table :notices do |t|
      t.string :title
      t.text :content
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
    add_index :notices, [:user_id, :created_at]
  end
end
