class AddProfileToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :name, :string unless column_exists?(:users, :name)
    add_column :users, :bio, :text unless column_exists?(:users, :bio)
  end
end
