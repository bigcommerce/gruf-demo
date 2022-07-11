# frozen_string_literal: true

ENV['RAILS_ENV'] = 'test'
ENV['RACK_ENV'] = 'test'
require 'dotenv'
require 'pry'
Dotenv.load
require 'faker'
require_relative '../config/environment'
abort("The Rails environment is running in production mode!") if Rails.env.production?

Dir[Rails.root.join("spec/support/**/*.rb")].sort.each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.mock_with :rspec do |mocks|
    mocks.allow_message_expectations_on_nil = true
  end
  config.color = true
end
