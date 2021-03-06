source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.1'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

gem 'devise', '~> 4.5.0'
# gem 'devise-jwt', '~> 0.5.8'
gem 'knock', '~> 2.1', '>= 2.1.1'
gem 'cancancan', '~> 2.3'
gem 'rolify', '~> 5.2'
gem 'kaminari', '~> 1.1', '>= 1.1.1'
gem "paperclip", "~> 6.0.0"
gem 'ffaker'
gem "aws-sdk-s3", require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'cucumber', '~> 3.1', '>= 3.1.2'
  gem 'rspec-rails', '~> 3.8'
  # gem 'fabrication', '~> 2.20', '>= 2.20.1'
  gem 'capybara', '~> 3.9'
  # gem 'factory_bot_rails'
  gem 'shoulda-matchers', '4.0.0.rc1'
  gem 'rails-controller-testing'
  gem 'database_cleaner'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end


# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

