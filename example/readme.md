# Run the sample

```
cd example
bundle update
bundle exec rspec spec/ios_example_spec.rb
```

# Use `irb` or `pry`

You may need to add `pry` in Gemfile to use `pry` under `bundle`, otherwise you can insert `binding.irb` or `binding.pry` in the example code if needed.

```bash
$ bndle exec irb
```

```ruby
# start an irb or pry session and paste the following code
# run from the example folder
require 'appium_capybara'

Capybara.register_driver(:appium) do |app|
  Appium::Capybara::Driver.new app, capabilities: {
      'platformName' => 'ios',
      'platformVersion' => ENV['PLATFORM_VERSION'] || '16.0',
      'appium:deviceName' => 'iPhone 12',
      'appium:automationName' => 'xcuitest',
      'appium:app' => File.expand_path('UICatalog.app.zip'),
      'appium:wdaLaunchTimeout' => 600000,
    },
    appium_lib: { server_url: 'http://localhost:4723/wd/hub' },
    global_driver: false
end

Capybara.default_driver = :appium

capy_driver = Capybara.current_session.driver
capy_driver.browser

# now driver commands can be invoked
> capy_driver.go_back
post /back
```
