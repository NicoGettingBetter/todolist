require 'spec_helper'

RSpec.configure do |config|
  config.include Warden::Test::Helpers
  config.include Capybara::Angular::DSL
  config.before :suite do
    Warden.test_mode!
  end
end