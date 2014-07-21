require 'rails_helper'

RSpec.describe "StaticPages", :type => :request do
  shared_examples_for "all static pages" do
    it { expect(response.status).to be(200) } 
  end

  describe "GET /home" do
    it "/home loads" do
      get "/home"
      expect(response).to render_template("home")
    end
  end

  describe "GET /help" do
    it "/help loads" do
      get "/help"
      expect(response).to render_template("help")
    end
  end

  describe "GET /contact" do
    it "/contact loads" do
      get "/contact"
      expect(response).to render_template("contact")
    end
  end

  describe "GET /about" do
    it "/about loads" do
      get "/about"
      expect(response).to render_template("about")
    end
  end
end

describe "Static pages" do
  subject { page }
  let(:base_title) { "Exotemporalis" }

  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    expect(page).to have_title(full_title("About"))
    click_link "Help"
    expect(page).to have_title(full_title("Help"))
    click_link "Contact"
    expect(page).to have_title(full_title("Contact"))
    click_link "Home"
    expect(page).to have_title(full_title("Home"))
  end

  shared_examples_for "all static pages" do
    it 'should not have a malformed title' do
      expect(page.title).not_to match /^\| Exotemporalis/
    end

    it 'should not have JavaScript errors', :js => true do
      expect(page).not_to have_errors
    end
  end

  describe "contact page" do
    before { visit contact_path }

    it { is_expected.to have_content("You should already know") }
    it { is_expected.to have_title("Contact | Exotemporalis") }
  end

  describe "Home page" do
    before { visit home_path }

    it { is_expected.to have_content("Exotemporalis") }
    it { is_expected.to have_title("Home | Exotemporalis") }
    it { is_expected.to have_link("Users") }
    it { is_expected.to have_link("Reminders") }
    it { is_expected.to have_link("Notifications") }
    it { is_expected.to have_link("Sign up") }
  end

  describe "Help page" do
    before { visit help_path }

    it { is_expected.to have_content("very helpful") }
    it { is_expected.to have_title("Help | Exotemporalis") }
  end

  describe "About page" do
    before { visit about_path }

    it { is_expected.to have_content("About") }
    it { is_expected.to have_title("About | Exotemporalis") }
  end
end