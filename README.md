# appium_capybara  [![Gem Version](https://badge.fury.io/rb/appium_capybara.svg)](http://badge.fury.io/rb/appium_capybara)


Gem enabling appium support in capybara

## Driver Setup
Set up the appium_capybara driver by running this before starting your test.

```ruby
require 'appium_capybara'

desired_caps_ios = {
  platform:        "Mac",
  deviceName:      "iPhone Simulator",
  platformName:    "iOS",
  platformVersion: "7.1",
  app:             "full/path/to/app.zip"
}

url = "http://localhost:4723/wd/hub" # or a sauce labs url

Capybara.register_driver(:appium) do |app|
    appium_lib_options = {
      server_url:           url
    }
    all_options = {
      appium_lib:  appium_lib_options,
      caps:        desired_caps_ios
    }
    Appium::Capybara::Driver.new app, all_options
end

Capybara.default_driver = :appium
```

## Capybara server
appium_capybara driver automatically starts a Rails server in `test` environment.

By default Capybara starts this web server listening to localhost only and on a random port. It is advised
to force Capybara to listen to all interface and listen to a specific port, and set this server address
in your mobile application.

```ruby
Capybara.server_host = '0.0.0.0' # Listen to all interfaces
Capybara.server_port = 56844     # Open port TCP 56844, change at your convenience
```

## Publishing to rubygems

Make sure to run `thor bump` or manually modify version.rb before publishing. RubyGems will not allow the same
version to be published twice. After the version is bumped, run `thor publish`
