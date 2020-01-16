class AddCredentialToEstablishment < ActiveRecord::Migration[6.0]
  def change
    add_reference :establishments, :credentials
  end
end
