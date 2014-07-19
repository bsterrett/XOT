require 'rails_helper'

describe User, :type => :model do
  it 'can be created' do
    user = create(:user)
    expect(user).to be
  end

  it 'can be created with reminders' do
    user = create(:user_with_reminders)
    expect(user.reminders.count).to be >0
  end

  it 'can be created with notifications' do
    user = create(:user_with_reminders)
    expect(user.notifications.count).to be >0
  end

  it 'can have reminders added' do
    user = create(:user, first_name: "Fred", last_name: "Flintstone")
    expect(user.reminders.count).to be 0
    reminder = create(:reminder)
    expect(user.reminders.count).to be 0
    user.reminders << reminder
    expect(user.reminders.count).to be 1
  end

  it 'can be assigned different names' do
    user = create(:user, first_name: "Tony", last_name: "Danza")
    expect(user.first_name).to match "Tony"
    expect(user.last_name).to match "Danza"
  end
end