class AddTokenToUser < ActiveRecord::Migration[5.0]
  def up
    add_column :users, :token, :string
    add_index :users, :token
  end

  def down
    remove_column :users, :token
  end
end
