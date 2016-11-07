# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'support/devise'
require 'support/capybara'
require 'support/database_cleaner'
require 'shoulda/matchers'
require 'support/test_helper'
require 'capybara/rspec'
require 'capybara/rails'
require 'capybara/webkit/matchers'
require 'capybara-webkit'
require 'capybara/poltergeist'
require 'database_cleaner'
require 'ffaker'
require 'support/connection'

Capybara.javascript_driver = :chrome
Capybara.default_driver = :poltergeist
Capybara.run_server = true
Capybara.server_port = 7000
Capybara.app_host = "http://localhost:#{Capybara.server_port}"

Capybara.register_driver :chrome do |app|
  Capybara::Poltergeist::Driver.new(app, { browser: :chrome, inspector: true, timeout: 10000})
end

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = false

  Shoulda::Matchers.configure do |config|
    config.integrate do |with|
      with.test_framework :rspec
      with.library :rails
    end
  end

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!

  config.include(Capybara::Webkit::RspecMatchers, :type => :feature)
  config.include(TestHelper)
  config.include(Capybara::Angular::DSL)

  Capybara::Angular.default_max_wait_time = 30

  config.use_transactional_fixtures = false

  config.before :all do
    ENV['PRECOMPILE_ASSETS'] ||= begin
      case self.class.metadata[:type]
      when :feature, :view
        STDOUT.write "Precompiling assets..."

        require 'rake'
        Rails.application.load_tasks
        Rake::Task['assets:precompile'].invoke

        STDOUT.puts " done."
        Time.now.to_s
      end
    end

  end
end
