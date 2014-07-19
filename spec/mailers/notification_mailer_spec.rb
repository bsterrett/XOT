require "rails_helper"

RSpec.describe NotificationMailer, :type => :mailer do
  before(:each) do
    ActionMailer::Base.delivery_method = :test
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries = []
    notification = create(:notification)
    NotificationMailer.notification_email(notification).deliver
  end

  after(:each) do
    ActionMailer::Base.deliveries.clear
  end

  it 'should send an email' do
    expect(ActionMailer::Base.deliveries.count).to equal(1)
  end

  it 'should have the correct subject line' do
    expect(ActionMailer::Base.deliveries.first.subject).to match /Important Engagement/
  end

  it 'renders the sender email' do  
    expect(ActionMailer::Base.deliveries.first.from).to match ['jovialben@gmail.com']
  end
end
