# OAuth2Me

OAuth2Me is a ruby client for the [oauth2.me](http://oauth2.me/) service.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'oauth2-me', github: 'tmwh/oauth2-me-ruby'
```

And then execute:

```
$ bundle
```

## Usage

### Devise
 
If you are using devise in your application, you should add this to your `initializers/devise.rb`:

```ruby
OAuth2Me.setup_devise! unless Rails.env.production?
```

### Omniauth

The work is still in progress.

## Contributing

1. Fork it ( https://github.com/tmwh/oauth2-me-ruby/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
