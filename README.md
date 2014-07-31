# appium_capybara  [![Gem Version](https://badge.fury.io/rb/appium_capybara.svg)](http://badge.fury.io/rb/appium_capybara)[![Dependency Status](https://gemnasium.com/appium/appium_capybara.svg)](https://gemnasium.com/appium/appium_capybara)


Gem enabling appium support in capybara

## Driver Setup
Set up the appium_capybara driver by running this before starting your test.

```ruby
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

## Publishing to rubygems

Make sure to run `thor bump` or manually modify version.rb before publishing. RubyGems will not allow the same
version to be published twice. After the version is bumped, run `thor publish`
