# Use this file to easily define all of your cron jobs.

# Learn more: http://github.com/javan/whenever

# HOW TO UPDATE:
# >> whenever --update-crontab

set :output, File.join(Whenever.path, "log", "cron.log")

every 2.minutes do
  rake "dispatch:notifications RAILS_ENV=development"
end

every 10.minutes do
  rake "clean:notifications"
end

every 30.minutes do
  rake "schedule:all"
end
