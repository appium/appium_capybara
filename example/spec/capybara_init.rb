require 'rspec'
require 'capybara'
require 'capybara/rspec'
require 'appium_capybara'
require 'site_prism'

Capybara.register_driver(:appium) do |app|
  Appium::Capybara::Driver.new app, capabilities: {
      'platformName' => 'ios',
      'platformVersion' => ENV['PLATFORM_VERSION'] || '17.4',
      'appium:deviceName' => ENV['DEVICE_NAME'] || 'iPhone 15 Plus',
      'appium:automationName' => 'xcuitest',
      'appium:app' => File.expand_path('UICatalog.app.zip'),
      'appium:wdaLaunchTimeout' => 600_000,
      'appium:simulatorStartupTimeout' => 600_000
    },
    appium_lib: { server_url: 'http://localhost:4723' },
    global_driver: false
end

Capybara.default_driver = :appium
