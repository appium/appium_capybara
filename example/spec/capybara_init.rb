require 'rspec'
require 'capybara'
require 'capybara/rspec'
require 'appium_capybara'
require 'site_prism'

caps = Appium.load_appium_txt file: File.expand_path('./', 'appium.txt'), verbose: true

url = "http://localhost:4723/wd/hub"

Capybara.register_driver(:appium) do |app|
  all_options = caps.merge({appium_lib: {server_url: url}, global_driver: false})
  puts all_options.inspect

  Appium::Capybara::Driver.new app, all_options
end

Capybara.default_driver = :appium
