require 'base64'
require 'oauth2-me/omniauth_strategy_updater'
require 'oauth2-me/railtie' if defined?(Rails)

module OAuth2Me
  class BannedEnvironmentError < StandardError; end
  mattr_accessor :redirect_url
  self.redirect_url= 'http://oauth2.me/redirect'

  class << self
    def banned_environments
      @@banned_environments = ['production']
    end

    def omniauth_strategy_updater
      @@omniauth_strategy_updater ||= OAuth2Me::OmniauthStrategyUpdater.new
    end

    def setup_devise!
      check_setup!
      Devise::OmniAuth::Config.send :define_method, :strategy_class_with_redirect do
        strategy_class = strategy_class_without_redirect
        OAuth2Me.omniauth_strategy_updater.setup_omniauth_strategy(strategy_class)
      end
      Devise::OmniAuth::Config.alias_method_chain :strategy_class, :redirect
    end

    def check_setup!
      environment = ENV['RAILS_ENV'] || ENV['RACK_ENV']
      raise BannedEnvironmentError.new if environment && banned_environments.include?(environment)
    end
  end
end
