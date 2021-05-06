class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title
      t.text :body
      t.references :user, foreign_key: true
      t.integer :user_id
      t.float :rate, null: false, default: 0

      t.timestamps
    end
  end
end
