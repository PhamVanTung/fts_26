set :output, "log/cron_log.log"

every 2.hours do
  runner "User.send_mail"
end
