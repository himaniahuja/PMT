source 'http://rubygems.org'



gem 'rails', '3.0.9'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger (ruby-debug for Ruby 1.8.7+, ruby-debug19 for Ruby 1.9.2+)
# gem 'ruby-debug'
# gem 'ruby-debug19', :require => 'ruby-debug'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
# group :development, :test do
#   gem 'webrat'
# end

#suggested gems by Todd
gem 'jquery-rails', '>= 1.0.3'
gem 'rspec-rails', :group => [:test, :development]
gem 'simplecov', :require => false, :group => :test
gem 'devise' 

gem 'will_paginate','3.0.2'
gem 'cancan', '>= 1.6.7'
gem 'heroku'

gem 'yard'
gem 'rdiscount'

group :development, :test do
  gem 'factory_girl_rails' 
  gem "capybara"

  if RUBY_VERSION =~ /1.9/
         gem 'ruby-debug19'
       else
         gem 'ruby-debug'
       end

  #gem 'ruby-debug19'
  #gem 'ruby-debug-base19x'
  gem 'ruby-debug-ide' #'0.4.6'
  gem 'sqlite3'
end

group :development do
 gem 'annotate'
end


