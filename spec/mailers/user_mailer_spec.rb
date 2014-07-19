require "rails_helper"

RSpec.describe UserMailer, :type => :mailer do
  before(:each) do
    ActionMailer::Base.delivery_method = :test
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries = []
    user = create(:user)
    UserMailer.welcome_email(user).deliver
  end

  after(:each) do
    ActionMailer::Base.deliveries.clear
  end

  it 'should send an email' do
    expect(ActionMailer::Base.deliveries.count).to equal(1)
  end

  it 'should have the correct subject line' do
    expect(ActionMailer::Base.deliveries.first.subject).to match /Thanks for signing up!/
  end

  it 'renders the sender email' do  
    expect(ActionMailer::Base.deliveries.first.from).to match ['jovialben@gmail.com']
  end
end
