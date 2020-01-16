class CreateEstablishments < ActiveRecord::Migration[6.0]
  def change
    create_table :establishments do |t|
      t.string :number, null: false
      t.belongs_to :shop

      t.timestamps
    end
    add_index :establishments, :number, unique: true
  end
end
