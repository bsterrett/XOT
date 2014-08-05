namespace :schedule do
  desc "Create notifications from reminders"
  task :notifications => :environment do
    Reminder.all.each do |r|
      puts r.trigger_at - Time.now
      if r.trigger_at - Time.now > 0 && r.trigger_at - Time.now < 3600
      # if r.trigger_at - Time.now < 3600
        if r.notifications.where(trigger_at: r.trigger_at).count == 0
          r.notifications.create(title: r.title, text: r.text, dispatched: 0, trigger_at: r.trigger_at)
        end

        if r.recurring?
          r.update(trigger_at: r.trigger_at+r.recurrence_period)
        end
      end
    end
  end
end
