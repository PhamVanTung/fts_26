class ApplicationMailer < ActionMailer::Base
  default from: Settings.default_mail
  layout 'mailer'
end
