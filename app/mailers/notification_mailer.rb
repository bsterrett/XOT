class NotificationMailer < ActionMailer::Base
  default from: "jovialben@gmail.com"

  def notification_email(notification)
    @notification = notification
    mail(to: @notification.reminder.user.email, subject: @notification.reminder.title)
  end
end
