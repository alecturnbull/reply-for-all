class AddFlagsToPledges < ActiveRecord::Migration
  def change
    add_column :pledges, :complete, :boolean
    add_column :pledges, :success, :boolean
  end
end
