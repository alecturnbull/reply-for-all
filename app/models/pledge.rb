class Pledge < ActiveRecord::Base
  attr_accessible :expiration, :project_id, :recipient, :sender, :sent_at, :time_limit, :amount
end
