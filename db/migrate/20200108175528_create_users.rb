class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :password, null: false
      t.string :first_name, null: false
      t.string :last_name, null:false
      t.belongs_to :account
      t.index :email, unique: true


      t.timestamps
    end
  end
end
