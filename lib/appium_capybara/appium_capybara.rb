require "appium_lib"
require "capybara"
require_relative 'driver/appium/driver'
require_relative 'driver/appium/node'

require_relative 'ext/query_ext'
require_relative 'ext/selector_ext'
require_relative 'ext/session_ext'

module AppiumCapybara
end