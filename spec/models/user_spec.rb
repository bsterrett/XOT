require 'rails_helper'

describe User, :type => :model do
  describe '' do
    before { @user = create(:user, first_name: "Example", last_name: "User", email: "user@example.com",
      password: "terriblepassword", password_confirmation: "terriblepassword") }

    subject { @user }

    it { is_expected.to respond_to(:first_name) }
    it { is_expected.to respond_to(:last_name) }
    it { is_expected.to respond_to(:email) }
    it { is_expected.to respond_to(:reminders) }
    it { is_expected.to respond_to(:notifications) }
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:password_digest) }
    it { is_expected.to respond_to(:password) }
    it { is_expected.to respond_to(:password_confirmation) }
    it { is_expected.to respond_to(:authenticate) }

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
                       foo@bar_baz.com foo@bar+baz.com foo@bar..com]
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

    describe "when password is not present" do
      before do 
        @user = User.new(first_name: "a", last_name: "z", email: "ex@mple.com",
          password: " ", password_confirmation: " ")
      end

      it { is_expected.not_to be_valid }
    end

    describe "when password doesn't match confirmation" do
      before { @user.password_confirmation = "mismatch" }
      it { is_expected.not_to be_valid }
    end

    describe "return value of authenticate method" do
      before { @user.save }
      let(:found_user) { User.find_by(email: @user.email) }

      describe "with valid password" do
        it { is_expected.to eq found_user.authenticate(@user.password) }
      end

      describe "with invalid password" do
        let(:user_for_invalid_password) { found_user.authenticate("invalid") }

        it { is_expected.not_to eq user_for_invalid_password }
        specify { expect(user_for_invalid_password).to eq false }
      end
    end

    describe "with a password that's too short" do
      before { @user.password = @user.password_confirmation = "a" * 5 }
      it { is_expected.to be_invalid }
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
    @user = User.new(first_name: "Bono", email: "ex@mple.com")
    expect(@user).not_to be_valid
  end

  it 'cannot be created without a first name' do
    @user = User.new(last_name: "Plato", email: "ex@mple.com")
    expect(@user).not_to be_valid
  end

  it 'cannot be created with a long first name' do
    @user = User.new(first_name: "a"*51, last_name: "a", email: "ex@mple.com")
    expect(@user).not_to be_valid
  end

  it 'cannot be created with a long last name' do
    @user = User.new(last_name: "z"*51, first_name: "z", email: "ex@mple.com")
    expect(@user).not_to be_valid
  end
end