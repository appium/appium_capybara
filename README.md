appium_capybara
===============

Gem enabling appium support in capybara

##Driver Setup
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