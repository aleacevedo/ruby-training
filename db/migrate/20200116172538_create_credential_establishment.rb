class CreateCredentialEstablishment < ActiveRecord::Migration[6.0]
  def change
    create_table :credential_establishments do |t|
      t.references :credentials, null: false, foreign_key: true
      t.references :establishment, null: false, foreign_key: true
    end
  end
end
