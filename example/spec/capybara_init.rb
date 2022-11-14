require 'rspec'
require 'capybara'
require 'capybara/rspec'
require 'appium_capybara'
require 'site_prism'

Capybara.register_driver(:appium) do |app|
  Appium::Capybara::Driver.new app, capabilities: {
      'platformName' => 'ios',
      'platformVersion' => '16.0',
      'appium:deviceName' => 'iPhone 12',
      'appium:automationName' => 'xcuitest',
      'appium:app' => File.expand_path('UICatalog.app.zip'),
      'appium:wdaLaunchTimeout' => 600000,
    },
    appium_lib: { server_url: 'http://localhost:4723/wd/hub' },
    global_driver: false
end

Capybara.default_driver = :appium
