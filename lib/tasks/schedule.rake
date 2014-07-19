namespace :schedule do
  desc "Create notifications from reminders"
  task :notifications => :environment do
    Reminder.all.each do |r|
      if r.trigger_at.in_next_hour?
        unless r.notifications.where(trigger_at: r.trigger_at).count > 0
          r.notifications.create(text_content: r.text_content, dispatched: 0, trigger_at: r.trigger_at)
        end
      end
    end
  end
end
