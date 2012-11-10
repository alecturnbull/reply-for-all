class CreatePledges < ActiveRecord::Migration
  def change
    create_table :pledges do |t|
      t.string :project_id
      t.datetime :expiration
      t.datetime :sent_at
      t.string :sender
      t.string :recipient

      t.timestamps
    end
  end
end
