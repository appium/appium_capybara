module Appium::Capybara
  class Appium::Capybara::Node < Capybara::Driver::Node
    def [](name)
      native.attribute(name.to_s)
    rescue Selenium::WebDriver::Error::WebDriverError
      nil
    end

    def value
      native.value
    end

    def label
      native.label
    end

    def name
      native.name
    end

    def set(value)
      native.clear
      send_keys(value)
    end

    def send_keys(value)
      native.send_keys(value.to_s)
    end

    def click
      native.click
    end

    def long_press
      action = Appium::TouchAction.new
      action.long_press(element: native, duration: 2000)
      action.perform
    end

    def tag_name
      native.tag_name
    end

    def visible?
      displayed = native.displayed?
      displayed && displayed != "false"
    end

    def selected?
      selected = native.selected?
      selected && selected != "false"
    end

    def disabled?
      !native.enabled?
    end

    def find_xpath(locator)
      native.find_elements(:xpath, locator).map { |n| self.class.new(driver, n) }
    end

    def find_css(locator)
      native.find_elements(:css, locator).map { |n| self.class.new(driver, n) }
    end

    def find_custom(finder, locator)
      native.find_elements(finder, locator).map { |n| self.class.new(driver, n) }
    end

    def ==(other)
      native == other.native
    end

    def inspect
      %(#<#{self.class} name="#{name}">)
    end
  end
end
