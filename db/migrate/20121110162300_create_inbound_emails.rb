class CreateInboundEmails < ActiveRecord::Migration
  def change
    create_table :inbound_emails do |t|
      t.string :project_id
      t.string :sent_at
      t.string :expiration
      t.string :sender
      t.string :recipient

      t.timestamps
    end
  end
end
