require 'rails_helper'

describe "UserPages" do
  subject { page }

  describe "signup page" do
    let(:submit) { "Create User" }
    before { visit signup_path }

    it { is_expected.to have_content('Sign Up') }
    it { is_expected.to have_title('Sign Up | Exotemporalis') }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button submit }
        it { is_expected.to have_content('error') }
      end
    end

    describe "with valid information" do
      before do
        fill_in "First name",   with: "Example"
        fill_in "Last name",    with: "User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Password confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after submission" do
        before { click_button submit }
        it { is_expected.not_to have_content('error') }
        it { should have_link('Sign out') }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
      end
    end
  end

  describe "profile page" do
    let(:user) { create(:user) }
    before { visit user_path(user) }

    it { is_expected.to have_content(user.first_name) }
    it { is_expected.to have_title(user.first_name) }
  end
end