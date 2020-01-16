class AddCredentialToEstablishment < ActiveRecord::Migration[6.0]
  def change
    add_column :establishments, :credential, :reference
  end
end
