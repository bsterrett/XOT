FactoryGirl.define do
  factory :user do
    first_name "foo"
    last_name "bar"
    email "foo@bar.com"

    factory :user_with_reminders do
      after(:create) do |user, evaluator|
        create_list(:reminder_with_notifications, 3, user: user)
      end
    end
  end

  factory :reminder do
    title "Important Engagement"
    text "You need to be at a certain place."
    recurring false
    trigger_at Time.now+5
    user

    factory :reminder_with_notifications do
      after(:create) do |reminder, evaluator|
        create_list(:notification, 5, reminder: reminder)
      end
    end

    factory :reminder_with_countdown_notifications do
      after(:create) do |reminder, evaluator|
        reminder.notifications << create(:notification, text: "#{reminder.text}\n10 minutes till.", title: reminder.title, trigger_at: reminder.trigger_at+600)
        reminder.notifications << create(:notification, text: "#{reminder.text}\n8 minutes till.", title: reminder.title, trigger_at: reminder.trigger_at+480)
        reminder.notifications << create(:notification, text: "#{reminder.text}\n6 minutes till.", title: reminder.title, trigger_at: reminder.trigger_at+360)
        reminder.notifications << create(:notification, text: "#{reminder.text}\n4 minutes till.", title: reminder.title, trigger_at: reminder.trigger_at+240)
        reminder.notifications << create(:notification, text: "#{reminder.text}\n2 minutes till.", title: reminder.title, trigger_at: reminder.trigger_at+120)
        reminder.notifications << create(:notification, text: "#{reminder.text}\nRight Now!", title: reminder.title, trigger_at: reminder.trigger_at)
      end
    end
  end

  factory :notification do
    title "Momentus Meeting"
    text "There is a place that you need to be."
    dispatched false
    trigger_at Time.now+5
    reminder
  end
end
