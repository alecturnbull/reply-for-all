class InboundEmail < ActiveRecord::Base
  attr_accessible :expiration, :project_id, :recipient, :sender, :sent_at
end
