require 'appium_capybara'

Capybara.register_driver(:appium) do |app|
    opts = Appium.load_appium_txt file: __FILE__
    Appium::Capybara::Driver.new app, opts
end

Capybara.default_driver = :appium

