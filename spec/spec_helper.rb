require 'capybara/rspec'
require 'capybara/webkit/matchers'
require 'factory_girl_rails'

Capybara.javascript_driver = :webkit

RSpec.configure do |config|
  # disable should syntax, force expect
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include FactoryGirl::Syntax::Methods
  config.include Capybara::DSL

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
    FactoryGirl.lint
  end
  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.include(Capybara::Webkit::RspecMatchers, :type => :feature)
end