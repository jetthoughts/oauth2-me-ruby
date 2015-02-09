module OAuth2Me
  class Railtie < Rails::Railtie
    initializer "oauthtome" do
      if defined?(Devise)
        OAuth2Me.setup_devise! unless Rails.env.production?
      end
    end
  end
end
