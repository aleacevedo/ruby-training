class CreateEstablishments < ActiveRecord::Migration[6.0]
  def change
    create_table :establishments do |t|
      t.string :number

      t.timestamps
    end
  end
end
