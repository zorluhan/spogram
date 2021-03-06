Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = true

  # Do not eager load code on boot.
  config.eager_load = true

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = true

  config.action_mailer.perform_deliveries = true

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load
  config.assets.compile = true

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true
  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

  #config.action_mailer.smtp_settings = { :address => "localhost", :port => 1025 }

  config.action_mailer.delivery_method = :smtp

  # config.action_mailer.smtp_settings = {
  #   address:        'smtp.gmail.com',
  #   port:           465,
  #   domain:         'gmail.com',
  #   user_name:      'mail@capish.co',
  #   password:       'gjlpatqzqfjvnjsg',
  #   authentication: :login,
  #   ssl:            true,
  #   :enable_starttls_auto  => true 
  # }
  ActionMailer::Base.smtp_settings = {
    :user_name => Rails.application.secrets.sndgr_name,
    :password => Rails.application.secrets.sndgr_pwd,
    :domain => 'capish.co',
    :address => 'smtp.sendgrid.net',
    :port => 587,
    :authentication => :plain,
    :enable_starttls_auto => true
  }

  INSTAGRAM_CALLBACK_URL = "http://localhost:3000/callback"

end

