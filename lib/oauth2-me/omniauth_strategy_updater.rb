module OAuth2Me
  class OmniauthStrategyUpdater
    def setup_omniauth_strategy(strategy_class)
      if strategy_class < OmniAuth::Strategies::OAuth2
        redefine_client(strategy_class)
      end
      strategy_class
    end

    private
    def redefine_client(strategy_class)
      strategy_class.send :define_method, :client_with_redirect do
        client_without_redirect.extend(ClientWithRedirectMethods)
      end
      strategy_class.alias_method_chain :client, :redirect
    end
  end

  module ClientWithRedirectMethods
    def authorize_url(params = nil)
      url = super
      oauth2_me_uri = URI(OAuth2Me.authorize_url)
      oauth2_me_uri.query = URI.encode_www_form(request_uri: url)
      oauth2_me_uri.to_s
    end
  end
end
