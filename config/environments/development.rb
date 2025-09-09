# frozen_string_literal: true

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  config.hosts << "platform.doctour.com.mx"

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  # Run rails dev:cache to toggle caching.
  if Rails.root.join("tmp", "caching-dev.txt").exist?
    config.cache_store = :memory_store
    config.public_file_server.headers = {
      "Cache-Control" => "public, max-age=#{2.days.to_i}",
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Store uploaded files on the local file system (see config/storage.yml for options).
  config.active_storage.service = :local

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  Rails.logger = Logger.new(STDOUT)
  config.logger = ActiveSupport::Logger.new("log/#{Rails.env}.log")

  config.action_mailer.perform_caching = false

  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    :user_name => ENV.fetch('SMTP_USERNAME'),  
    :password =>  ENV.fetch('SMTP_PASSWORD'),
    :address => ENV.fetch('SMTP_ADDRESS', 'smtp.office365.com'),
    :domain => ENV.fetch('SMTP_DOMAIN', 'doctour.com.mx'), 
    :port => ENV.fetch('SMTP_PORT', '587'),
    :authentication => 'login',
    :tls => true,
    :enable_starttls_auto => true
  }

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true

  # Raises error for missing translations.
  # config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  #config.file_watcher = ActiveSupport::EventedFileUpdateChecker
  config.action_cable.url = "ws://localhost:3000/cable"

  config.action_cable.allowed_request_origins = [ENV.fetch('ACTION_CABLE_ALLOWED_ORIGINS', 'https://app.doctour.com.mx').split(',')].flatten
end
