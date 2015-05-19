# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.raise_delivery_errors = true

ActionMailer::Base.smtp_settings = {
  user_name: ENV['USERNAME'],
  password: ENV['PASSWORD'],
  domain: ENV['DOMAIN'],
  address: 'smtp.gmail.com',
  port: 587,
  authentication: :plain,
  enable_starttls_auto: true,
  openssl_verify_mode: 'none'
}
