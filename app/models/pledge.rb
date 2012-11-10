class Pledge < ActiveRecord::Base
  attr_accessible :expiration, :project_id, :recipient, :sender, :sent_at, :time_limit, :amount, :complete, :success

  before_save :set_expiration

  def set_expiration
    if self.sent_at
      parsed_time = ChronicDuration::parse(self.time_limit)
      self.expiration = sent_at + parsed_time
    end
  end

  def sender_email
    return self.sender.split("<")[1].gsub(">", "")
  end

  def sender_name
    return self.sender.split("<")[0].strip
  end

  def first_name
    return self.sender_name.split(" ")[0]
  end

  def last_name
    return self.sender_name.split(" ")[1]
  end

end
