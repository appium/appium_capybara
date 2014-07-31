require 'appium_capybara'

Capybara.register_driver(:appium) do |app|
    Appium::Capybara::Driver.new app, Appium.load_appium_txt file: __FILE__
end

Capybara.default_driver = :appium