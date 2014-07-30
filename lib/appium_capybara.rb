require "appium_lib"
require "capybara"
require_relative 'appium_capybara/driver/appium/driver'
require_relative 'appium_capybara/driver/appium/node'

require_relative 'appium_capybara/ext/base_ext'
require_relative 'appium_capybara/ext/query_ext'
require_relative 'appium_capybara/ext/selector_ext'
require_relative 'appium_capybara/ext/session_ext'

module Appium::Capybara
end