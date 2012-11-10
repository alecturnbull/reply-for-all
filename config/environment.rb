# Load the rails application
require File.expand_path('../application', __FILE__)

ActionMailer::Base.smtp_settings = {
  :address => "smtp.sendgrid.net",
  :port => '587',
  :domain => "donorschoose.alecturnbull.com",
  :authentication => :plain,
  :user_name => ENV['SENDGRID_USERNAME'],
  :password => ENV['SENGRID_PASSWORD'],
  :domain => "heroku.com"
}
ActionMailer::Base.delivery_method = :smtp

# Initialize the rails application
DonorsChoose::Application.initialize!
