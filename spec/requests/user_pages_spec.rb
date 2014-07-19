require 'rails_helper'

RSpec.describe "UserPages" do
  subject { page }

  describe "signup page" do
    before { visit signup_path }

    it { is_expected.to have_content('Sign Up') }
    it { is_expected.to have_title('Sign Up | Exotemporalis') }
  end
end