# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'dotenv-rails',   '>= 2.5'
gem 'faker',          '>= 1.9'
gem 'foreman',        '>= 0.85'
gem 'gruf',           '~> 2.9'
gem 'jbuilder',       '~> 2.5'
gem 'mysql2',         '>= 0.5'
gem 'puma',           '~> 5.5'
gem 'rails',          '~> 6'
gem 'settingslogic',  '~> 2.0'

group :development, :test do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'bundler-audit'
  gem 'grpc-tools'
  gem 'sqlite3', '~> 1.3'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'pry'
end

group :test do
  gem 'gruf-rspec'
  gem 'rspec'
  gem 'rspec-rails'
end

