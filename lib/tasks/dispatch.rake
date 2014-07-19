namespace :dispatch do
  desc "Send notifications that are due to be triggered."
  task :notifications => :environment do
    Notification.where(dispatched: false).each { |n| n.dispatch if n.trigger_at.past? }
  end

  desc "Dispatch all things."
  task :all => [:notifications]
end