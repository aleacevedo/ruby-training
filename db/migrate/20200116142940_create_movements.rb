class CreateMovements < ActiveRecord::Migration[6.0]
  def change
    create_table :movements do |t|
      t.string :type
      t.date :payment_date
      t.date :origin_date
      t.integer :provider
      t.decimal :amount
      t.integer :currency
      t.string :card_number
      t.string :coupon_number

      t.integer :installments_current
      t.integer :installments_number
      t.integer :installments_total
      t.decimal :discount_amount

      t.string :description_code

      t.belongs_to :payment

      t.timestamps
    end
  end
end
