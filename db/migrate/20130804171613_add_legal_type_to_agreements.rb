class AddLegalTypeToAgreements < ActiveRecord::Migration
  def change
    add_column :agreements, :legal_type, :string
  end
end
