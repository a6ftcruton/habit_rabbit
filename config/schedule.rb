# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
#
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

set :environment, "development" # set this to production for VPS
set :output, "log/cron_log.log"

every "*/15 * * * *" do
  runner "Habit.notify?"
end

every "0 0 20 1/1 * ? *" do
  runner "Habity.github_check"

every "* 0 * * * " do
runner 'Habit.all.each { |habit| habit.user_response? }'

end
