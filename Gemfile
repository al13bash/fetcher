source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.1'

gem 'activerecord-import'
gem 'kaminari'
gem 'nokogiri'
gem 'pg', '~> 0.18.4'
gem 'puma', '~> 3.7'
gem 'rest-client', '~> 2.0'

gem 'jbuilder', '~> 2.5'

group :development, :test do
  gem 'pry-rails'
  gem 'rubocop', '~> 0.48.1', require: false
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'database_cleaner'
  gem 'factory_girl_rails', '~> 4.0'
  gem 'rspec-activejob'
  gem 'rspec-rails', '~> 3.5'
  gem 'shoulda-callback-matchers', '~> 1.1.1'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'webmock'
end
