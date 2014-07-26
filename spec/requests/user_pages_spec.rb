require 'rails_helper'

RSpec.describe "UserPages" do
  subject { page }

  describe "signup page" do
    before { visit signup_path }

    it { is_expected.to have_content('Sign Up') }
    it { is_expected.to have_title('Sign Up | Exotemporalis') }
  end

  describe "profile page" do
    let(:user) { create(:user) }
    before { visit user_path(user) }

    it { should have_content(user.first_name) }
    it { should have_title(user.first_name) }
  end
end