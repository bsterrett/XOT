require 'rails_helper'

describe Notification, :type => :model do
  describe 'Hartl Guide Notification Tests' do
    before { @notification = create(:notification) }

    subject { @notification }

    it { is_expected.to respond_to(:reminder) }
    it { is_expected.to respond_to(:title) }
    it { is_expected.to respond_to(:text) }
    it { is_expected.to respond_to(:trigger_at) }
    it { is_expected.to respond_to(:dispatched) }
    it { is_expected.to respond_to(:dispatch) }
    it { is_expected.to respond_to(:user) }
    it { is_expected.to respond_to(:user_id) }
  end

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

  describe 'getting user from parent reminder' do
    before { @reminder = create(:reminder_with_notifications) }

    it 'should have a user' do
      expect(@reminder.notifications.last.user).to match(@reminder.user)
    end

    it 'should have a valid user id' do
      expect(@reminder.notifications.last.user_id).to match(@reminder.user.id)
    end
  end
end
