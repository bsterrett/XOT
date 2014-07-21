class User < ActiveRecord::Base
  validates :first_name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :last_name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }

  has_many :reminders

  def notifications
    notifications = []
    self.reminders.each do |reminder|
      notifications.concat(reminder.notifications)
    end
    return notifications
  end

  def name
    return "#{self.first_name} #{self.last_name}"
  end
end
