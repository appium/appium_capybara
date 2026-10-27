# appium_capybara  [![Gem Version](https://badge.fury.io/rb/appium_capybara.svg)](http://badge.fury.io/rb/appium_capybara)

[Documentation](https://www.rubydoc.info/gems/appium_capybara/)

Gem enabling appium support in capybara

Please use `v1.4.1` for Capybara 2.x users. `v1.5.0` requires Capybara 3.x.

## Driver Setup
Set up the `appium_capybara` driver by registering `:appium` with Capybara before starting your tests:

```ruby
require 'appium_capybara'

capabilities = {
  'platformName' => 'ios',
  'platformVersion' => ENV['PLATFORM_VERSION'] || '17.4',
  'appium:deviceName' => ENV['DEVICE_NAME'] || 'iPhone 15 Plus',
  'appium:automationName' => 'xcuitest',
  'appium:app' => File.expand_path('path/to/UICatalog.app.zip')
}

url = 'http://localhost:4723' # or a remote/cloud server URL

Capybara.register_driver(:appium) do |app|
  Appium::Capybara::Driver.new(
    app,
    capabilities: capabilities,
    appium_lib: { server_url: url },
    global_driver: false
  )
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

## Using Capybara DSL & Custom Selectors

`appium_capybara` registers the following Appium-specific selectors with Capybara in addition to `:xpath` and `:css`:
- `:id`
- `:class`
- `:name`
- `:accessibility_id`
- `:custom`

You can query elements through `Capybara.current_session` (or directly in RSpec feature specs):

```ruby
session = Capybara.current_session

# Find a single element or all matching elements using Capybara selectors
nav_bar = session.find(:xpath, '//XCUIElementTypeNavigationBar')
expect(nav_bar.find(:class, 'XCUIElementTypeButton').text).to eq('UIKitCatalog')

buttons = session.all(:class, 'XCUIElementTypeButton')
expect(buttons.count).to be > 0
```

> Note: Web-only Capybara navigation helpers such as `visit` or `click_link` only apply to web/hybrid contexts, not native mobile views.

## Using with SitePrism Page Objects

`appium_capybara` works with [SitePrism](https://github.com/site-prism/site_prism) pages and sections using the registered Appium selectors:

```ruby
require 'site_prism'

module Sections
  class Sheets < SitePrism::Section
    elements :buttons, :class, 'XCUIElementTypeButton'
  end
end

module Pages
  class Home < SitePrism::Page
    elements :navigation_bar, :accessibility_id, 'UIKitCatalog'
    section :action_sheets_section, Sections::Sheets, :name, 'Alert Views'
  end
end

home_page = Pages::Home.new
expect(home_page.navigation_bar.first).to be_truthy
expect(home_page.action_sheets_section.has_buttons?).to be(false)
```

## Driver & Node Methods

`appium_capybara` provides access to both `Appium::Capybara::Driver` helpers and the underlying `appium_lib` (`Appium::Driver`) / Selenium (`Appium::Core::Base::Driver`) instances:

```ruby
capy_driver = Capybara.current_session.driver

# Find elements with any Appium finder (:predicate, :class_chain, :uiautomator, :name, etc.)
# Returns an Array of Appium::Capybara::Node instances
nodes = capy_driver.find_custom(:predicate, 'value == "Placeholder text"')
node = nodes.first
node.name       # element name attribute
node.label      # element label attribute
node.set('abc') # clears the element and sends keys
node.send_keys([:shift, :end])

# Perform a W3C pointer swipe gesture (duration in ms, defaults to 200)
capy_driver.swipe(start_x: 100, start_y: 500, end_x: 100, end_y: 200, duration: 200)

# Scroll or rotate via driver helpers
capy_driver.scroll_down
capy_driver.scroll_up
capy_driver.rotate(:landscape) # or :portrait

# Save screenshots and handle alerts
capy_driver.save_screenshot('screen.png')
capy_driver.accept_modal(:alert)
capy_driver.dismiss_modal(:alert)

# Call methods defined on appium_lib (Appium::Driver) directly
capy_driver.appium_driver.find_element(:name, 'TextFields').click
capy_driver.appium_driver.hide_keyboard
capy_driver.appium_driver.back
```

See the complete working example in [`example/spec/`](example/spec/).

## Publishing to rubygems

Review and merge the Release Please PR to publish. See [RELEASING.md](RELEASING.md)
for one-time Trusted Publishing setup and recovery instructions.


## major changelogs
- v3.0.0
    - Support Ruby 3+ only

- v2.0.0
    - Bump base appium_lib version to v12
    - Bump base capybara version to over 3.36
    - Support Ruby 2.6+
