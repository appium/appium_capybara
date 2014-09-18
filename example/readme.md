# Run the sample

```
cd example
bundle update
rspec
```

# Use with pry

```ruby
# start a Pry session and paste the following code
# run from the example folder
require 'appium_capybara'

Capybara.register_driver(:appium) do |app|
  opts = Appium.load_appium_txt file: File.join(Dir.pwd, 'appium.txt')
  Appium::Capybara::Driver.new app, opts
end

Capybara.default_driver = :appium

capy_driver = Capybara.current_session.driver
capy_driver.browser

# now driver commands can be invoked
> capy_driver.go_back
post /back
```