require 'rails_helper'

describe User, :type => :model do
  describe '' do
    before { @user = create(:user, first_name: "Example", last_name: "User", email: "user@example.com") }

    subject { @user }

    it { is_expected.to respond_to(:first_name) }
    it { is_expected.to respond_to(:last_name) }
    it { is_expected.to respond_to(:email) }
    it { is_expected.to respond_to(:reminders) }
    it { is_expected.to respond_to(:notifications) }
    it { is_expected.to respond_to(:name) }

    it 'cannot be saved after removing the first name' do
      @user.first_name = ''
      expect(@user).not_to be_valid
    end

    it 'cannot be saved after removing the last name' do
      @user.last_name = ''
      expect(@user).not_to be_valid
    end

    it 'cannot be saved after removing the email' do
      @user.email = ''
      expect(@user).not_to be_valid
    end

    describe "when email format is invalid" do
      it "should be invalid" do
        addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                       foo@bar_baz.com foo@bar+baz.com]
        addresses.each do |invalid_address|
          @user.email = invalid_address
          expect(@user).not_to be_valid
        end
      end
    end

    describe "when email format is valid" do
      it "should be valid" do
        addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
        addresses.each do |valid_address|
          @user.email = valid_address
          expect(@user).to be_valid
        end
      end
    end
  end

  it 'can be created' do
    user = create(:user)
    expect(user).to be
  end

  it 'will have name forme from first and last name' do
    user = create(:user, first_name: "Bill", last_name: "Clinton")
    expect(user.name).to match("Bill Clinton")
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

  it 'cannot be created without a first name' do
    @user = User.new(first_name: "Bono")
    expect(@user).not_to be_valid
  end

  it 'cannot be created without a first name' do
    @user = User.new(last_name: "Plato")
    expect(@user).not_to be_valid
  end

  it 'cannot be created with a long first name' do
    @user = User.new(first_name: "a"*51)
    expect(@user).not_to be_valid
  end

  it 'cannot be created with a long last name' do
    @user = User.new(last_name: "z"*51)
    expect(@user).not_to be_valid
  end
end