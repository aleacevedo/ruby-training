class CreateShops < ActiveRecord::Migration[6.0]
  def change
    create_table :shops do |t|
      t.string :name, null: false
      t.string :address
      t.belongs_to :account

      t.timestamps
    end
  end
end
