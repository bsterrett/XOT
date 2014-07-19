ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  address:              'smtp.gmail.com',
  port:                 587,
  domain:               'bensreminders.net',
  user_name:            'jovialben',
  password:             'Mcnutt11',
  authentication:       'login',
  enable_starttls_auto: true  }