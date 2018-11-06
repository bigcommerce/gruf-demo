ENV['RAILS_ENV'] = 'test'

require 'dotenv'
Dotenv.overload
require 'faker'

require File.expand_path('../../config/environment', __FILE__)

Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  config.alias_example_to :fit, focus: true
  config.filter_run focus: true
  config.filter_run_excluding broken: true
  config.run_all_when_everything_filtered = true
  config.expose_current_running_example_as :example
  config.mock_with :rspec do |mocks|
    mocks.allow_message_expectations_on_nil = true
  end
  config.color = true
end
