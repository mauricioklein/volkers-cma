class CreateContracts < ActiveRecord::Migration[5.0]
  def change
    create_table :contracts do |t|
      t.string :vendor
      t.date :starts_on
      t.date :ends_on
      t.float :price
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
