class User < ActiveRecord::Base
  has_many :reminders

  def notifications
    notifications = []
    self.reminders.each do |reminder|
      notifications.concat(reminder.notifications)
    end
    return notifications
  end
  #attr_accessor :first_name, :last_name, :email
end
