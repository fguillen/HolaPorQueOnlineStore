# Be sure to restart your server when you modify this file

# Uncomment below to force Rails into production mode when
# you don't control web/app server and can't set it the proper way
# ENV['RAILS_ENV'] ||= 'production'

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.4' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.action_controller.session = {
    :session_key => '_tienda_session',
    :secret      => '1d483516819bc48fc33f6cfdb24a0b1f77cea3ebab9c74bfecce2cd214d406966d5c2eb49b367029d4eebb418749014543825046ee156323da1875df0ef96972'
  }
  
  config.time_zone = 'UTC'
  
  config.i18n.default_locale = :es
end



#
# ActionMailer
#
ActionMailer::Base.delivery_method = :sendmail
ActionMailer::Base.raise_delivery_errors = true