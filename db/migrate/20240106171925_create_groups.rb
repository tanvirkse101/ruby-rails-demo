class CreateGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :groups do |t|
      t.string :name
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :groups, [:user_id, :created_at]
  end
end
