require 'rails_helper'

describe Notification, :type => :model do
  it 'can be created' do
    notification = create(:notification)
    expect(notification).to be
  end

  it 'can be dispatched' do
    ActionMailer::Base.delivery_method = :test
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries = []
    notification = create(:notification)
    expect(ActionMailer::Base.deliveries.count).to eq(0)
    expect(notification).to respond_to(:dispatch)
    expect(notification.dispatched).to be(false)
    notification.dispatch
    expect(ActionMailer::Base.deliveries.count).to eq(1)
    expect(notification.dispatched).to be(true)
    ActionMailer::Base.deliveries.clear
  end

  it 'cant be dispatched more than once' do
    ActionMailer::Base.delivery_method = :test
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries = []
    notification = create(:notification)
    expect(ActionMailer::Base.deliveries.count).to eq(0)
    expect(notification.dispatched).to be(false)
    notification.dispatch
    expect(ActionMailer::Base.deliveries.count).to eq(1)
    expect(notification.dispatched).to be(true)
    notification.dispatch
    expect(ActionMailer::Base.deliveries.count).to eq(1)
    expect(notification.dispatched).to be(true)
    ActionMailer::Base.deliveries.clear
  end

  it 'can be created with custom text' do
    notification = create(:notification, text: "custom text")
    expect(notification.text).to match("custom text")
  end
end
