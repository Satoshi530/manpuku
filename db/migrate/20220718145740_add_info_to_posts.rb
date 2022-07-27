class AddInfoToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :info, :string
  end
end
