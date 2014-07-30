module Appium::Capybara
  class Appium::Capybara::Driver < Capybara::Driver::Base
    DEFAULT_OPTIONS = {
    }

    attr_reader :app, :options

    def browser
      unless @browser
        @browser = Appium::Driver.new @options
        # This will fail if your appium didn't close its last session
        @browser.start_driver
      end
      @browser
    end

    def initialize(app, options = {})
      @app = app
      @options = DEFAULT_OPTIONS.merge(options)
    end

    def browser_initialized?
      !@browser.nil?
    end

    def reset!
      # TODO: What do we want to do here?
    end

    def wait?
      false
    end

    def find_xpath(selector)
      browser.find_elements(:xpath, selector).map { |node| Appium::Capybara::Node.new(self, node) }
    end

    def find_css(selector)
      browser.find_elements(:css, selector).map { |node| Appium::Capybara::Node.new(self, node) }
    end

    def find_custom(finder, locator)
      browser.find_elements(finder, locator).map { |node| Appium::Capybara::Node.new(self, node) }
    end

    def quit
      @browser.driver_quit if @browser
    rescue Errno::ECONNREFUSED
      # Browser must have already gone
    ensure
      @browser = nil
    end

    def dismiss_alert
      browser.alert_dismiss
    end

    def accept_alert
      browser.alert_accept
    end

    def scroll_up
      browser.driver.execute_script("mobile: scroll", direction: "up")
    end

    def scroll_down
      browser.driver.execute_script("mobile: scroll", direction: "down")
    end

    # Use :landscape or :portrait
    def rotate(opts)
      browser.driver.rotate opts
    end
  end
end
