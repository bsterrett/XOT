require 'rails_helper'

describe Reminder, :type => :model do
  it 'can be created' do
    reminder = create(:reminder)
    expect(reminder).to be
    expect(reminder).to belong_to(:user)
  end

  it 'should have a user' do
    reminder = create(:reminder)
    expect(reminder.user).to be
  end

  it 'should have no notifications by default' do
    reminder = create(:reminder)
    expect(reminder).to have_many(:notifications)
    expect(reminder.notifications.count).to equal(0)
  end

  it 'can have notifications added' do
    reminder = create(:reminder_with_countdown_notifications)
    expect(reminder.notifications.count).to be >0
    expect(reminder.notifications).to respond_to(:new)
  end
end