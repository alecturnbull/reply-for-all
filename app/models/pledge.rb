class Pledge < ActiveRecord::Base
  attr_accessible :expiration, :project_id, :recipient, :sender, :sent_at, :time_limit, :amount, :complete, :success

  before_save :set_expiration

  def set_expiration
    if self.sent_at
      parsed_time = ChronicDuration::parse(self.time_limit)
      self.expiration = sent_at + parsed_time
    end
  end
end
