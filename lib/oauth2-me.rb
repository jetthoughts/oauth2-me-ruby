require 'base64'
require 'oauth2-me/omniauth_strategy_updater'
require 'oauth2-me/railtie' if defined?(Rails)

module OAuth2Me
  mattr_accessor :authorize_url
  self.authorize_url= 'http://www.jetthoughts.com/oauth2me/request'

  class << self
    def omniauth_strategy_updater
      @@omniauth_strategy_updater ||= OAuth2Me::OmniauthStrategyUpdater.new
    end

    def setup_devise!
      Devise::OmniAuth::Config.send :define_method, :strategy_class_with_redirect do
        strategy_class = strategy_class_without_redirect
        OAuth2Me.omniauth_strategy_updater.setup_omniauth_strategy(strategy_class)
      end
      Devise::OmniAuth::Config.alias_method_chain :strategy_class, :redirect
    end
  end
end
