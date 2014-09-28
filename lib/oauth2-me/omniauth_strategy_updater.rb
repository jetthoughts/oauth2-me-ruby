module OAuth2Me
  class OmniauthStrategyUpdater
    def setup_omniauth_strategy(strategy_class)
      if strategy_class < OmniAuth::Strategies::OAuth2
        redefine_callback_url(strategy_class)
        redefine_options_for(strategy_class)
      end
      strategy_class
    end

    private
    def redefine_callback_url(strategy_class)
      strategy_class.send :define_method, :callback_url_with_redirect do
        OAuth2Me.redirect_url
      end
      strategy_class.alias_method_chain :callback_url, :redirect
    end

    def redefine_options_for(strategy_class)
      strategy_class.send :define_method, :options_for_with_redirect do |option|
        return options_for_without_redirect(option) unless option == 'authorize'
        encoded_callback_url = Base64.strict_encode64(callback_url_without_redirect)
        options_for_without_redirect(option).merge(state: encoded_callback_url)
      end
      strategy_class.alias_method_chain :options_for, :redirect
    end
  end
end
