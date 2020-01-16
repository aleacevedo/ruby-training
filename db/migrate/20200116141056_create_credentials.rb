class CreateCredentials < ActiveRecord::Migration[6.0]
  def change
    create_table :credentials do |t|
      t.string :login, null: false
      t.string :password, null: false

      t.belongs_to :establishment

      t.timestamps
    end
    add_index :credentials, :login, unique: true
  end
end
