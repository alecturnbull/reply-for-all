class AddTimeLimitToPledges < ActiveRecord::Migration
  def change
    add_column :pledges, :time_limit, :string
  end
end
