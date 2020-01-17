class CreatePayments < ActiveRecord::Migration[6.0]
  def change
    create_table :payments do |t|
      t.date :payment_date
      t.date :origin_date
      t.integer :provider
      t.integer :document_type
      t.integer :clearing_number, unique: true
      t.decimal :total_amount
      t.decimal :total_deduction
      t.decimal :total_earn
      t.decimal :opening_balance
      t.decimal :closing_balance
      t.integer :currency
      t.boolean :is_balanced

      t.belongs_to :establishment

      t.timestamps
    end
  end
end
