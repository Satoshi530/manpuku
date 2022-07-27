class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :restaurant_name
      t.text :description
      t.integer :user_id
      t.float :rate
      t.timestamps
    end
  end
end
