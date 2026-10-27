module Appium::Capybara
  class Appium::Capybara::Node < Capybara::Selenium::Node
    def label
      native.label
    end

    def name
      native.name
    end

    # Override
    def set(value, _options = {})
      native.clear
      send_keys(value)
    end

    def long_press
      action_builder = driver.browser.action
      input = action_builder.pointer_inputs[0]
      action_builder
        .move_to(native)
        .pointer_down(:left)
        .pause(device: input, duration: 2)
        .release
        .perform
    end

    def find_custom(finder, locator)
      native.find_elements(finder, locator).map { |n| self.class.new(driver, n) }
    end

    def inspect
      %(#<#{self.class} name="#{name}">)
    end
  end
end
