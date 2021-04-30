# frozen_string_literal: true

ENV['RAILS_ENV'] = 'test'

require 'dotenv'
Dotenv.overload
require 'faker'

require File.expand_path('../config/environment', __dir__)

Dir[Rails.root.join("spec/support/**/*.rb")].sort.each { |f| require f }

ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  config.mock_with :rspec do |mocks|
    mocks.allow_message_expectations_on_nil = true
  end
  config.color = true
end
