# Use this file to easily define all of your cron jobs.

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

set :output, File.join(Whenever.path, "log", "cron.log")

every 2.minutes do
  rake "dispatch:notifications"
end

every 10.minutes do
  rake "clean:notifications"
end
