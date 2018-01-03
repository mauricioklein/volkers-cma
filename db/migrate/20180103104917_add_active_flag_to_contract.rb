class AddActiveFlagToContract < ActiveRecord::Migration[5.0]
  def up
    add_column :contracts, :active, :boolean
  end

  def down
    remove_column :contract, :active
  end
end
