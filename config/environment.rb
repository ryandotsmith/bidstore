# Be sure to restart your server when you modify this file

# Uncomment below to force Rails into production mode when
# you don't control web/app server and can't set it the proper way
# ENV['RAILS_ENV'] ||= 'production'

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.2' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.time_zone = 'UTC'
  config.action_controller.session = {
    :session_key => '_bidstore_session',
    :secret      => '5a81026b32946d079fabdd1280210cdb9d914416434503d7296603ac8c69429af4774c2c27cc81b7106a3c55be70f16cea46b0098bb55fe4e51ef3c573841ba6'
  }

  config.gem "geokit"

end
