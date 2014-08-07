namespace :schedule do
  desc "Create notifications from reminders"
  task :notifications => :environment do
    Reminder.all.each do |r|
      if r.trigger_at - Time.now > 0 && r.trigger_at - Time.now < 3600
      # if r.trigger_at - Time.now < 3600
        if r.notifications.where(trigger_at: r.trigger_at).count == 0
          r.notifications.create(title: r.title, text: r.text, dispatched: 0, trigger_at: r.trigger_at)
        end
      end
    end
  end

  task :reminders => :environment do
    Reminder.all.each do |r|
      if r.recurring? and r.trigger_at.past?
        new_time = r.trigger_at
        while new_time.past?
          new_time += r.recurrence_period
        end
        r.update(trigger_at: new_time)
      end
    end
  end

  task :all => [:notifications, :reminders]
end
