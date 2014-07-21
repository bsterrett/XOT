class Notification < ActiveRecord::Base
  belongs_to :reminder

  def user
    return self.reminder.user
  end

  def user_id
    return self.user.id
  end

  def dispatch
    unless self.dispatched
      NotificationMailer.notification_email(self).deliver
      self.update(dispatched: true)
    end
  end
end
