class AddCredentialReferenceToEstablishment < ActiveRecord::Migration[6.0]
  def change
    add_reference :establishments, :credentials, null: false, foreign_key: true
  end
end
