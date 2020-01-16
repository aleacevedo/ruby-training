class CreateMovements < ActiveRecord::Migration[6.0]
  def change
    create_table :movements do |t|
      t.string :type
      t.date :payment_date
      t.date :origin_date
      t.integer :provider
      t.big_decimal :amount
      t.integer :currency
      t.string :card_number
      t.string :coupon_number

      t.timestamps
    end
  end
end
