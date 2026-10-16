class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    return if table_exists?(:users)

    create_table :users do |t|
      t.string :uid
      t.string :pass

      t.timestamps
    end
  end
end
