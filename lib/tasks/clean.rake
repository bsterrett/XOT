namespace :clean do
  desc "Remove all dispatched notifications."
  task :notifications => :environment do
    Notification.all.each { |n| n.destroy if n.dispatched? }
  end

  desc "Remove all messy things."
  task :all => [:notifications]
end
