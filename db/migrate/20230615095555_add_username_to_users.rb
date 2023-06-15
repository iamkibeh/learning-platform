class AddUsernameToUsers < ActiveRecord::Migration[7.0]
  def up
    add_column :users, :username, :string
    add_index :users, :username, unique: true
  end

  def down
    remove_index :users, :username
    remove_column :users, :username
  end
end
