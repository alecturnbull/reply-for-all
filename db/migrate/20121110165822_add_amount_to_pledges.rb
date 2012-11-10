class AddAmountToPledges < ActiveRecord::Migration
  def change
    add_column :pledges, :amount, :string
  end
end
