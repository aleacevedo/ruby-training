class AddCredentialToEstablishment < ActiveRecord::Migration[6.0]
  def change
    add_reference :establishments, :credential
  end
end
