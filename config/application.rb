require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Rails101
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # SMTP settings for gmail
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      :address              => "smtp.gmail.com",
      :port                 => 587,
      :user_name            => Rails.application.secrets.GMAIL_USERNAME,
      :password             => Rails.application.secrets.GMAIL_PASSWORD,
      :authentication       => "plain",
      :enable_starttls_auto => true
    }

    # use for background delayed job
    config.active_job.queue_adapter = :delayed_job
  end
end
