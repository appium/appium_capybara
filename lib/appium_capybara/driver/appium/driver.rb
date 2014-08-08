module Appium::Capybara
  class Appium::Capybara::Driver < Capybara::Driver::Base
    DEFAULT_DRIVER_OPTIONS = {
        start_capybara_server: false
    }
    DEFAULT_OPTIONS = {
    }

    attr_reader :app, :options, :driver_options

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
      @driver_options = DEFAULT_DRIVER_OPTIONS.merge(options.delete(:driver_options) || {})
      @options = DEFAULT_OPTIONS.merge(options)
    end

    def browser_initialized?
      !@browser.nil?
    end

    def reset!
      browser.driver.reset
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

    def current_url
      raise NotImplementedError,
        "Appium::Capybara::Driver does not support current_url because it does not apply to mobile applications"
    end

    def visit(path)
      raise NotImplementedError,
        "Appium::Capybara::Driver does not support visit(path) because it does not apply to mobile applications"
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

    # Tell Capybara to start a web server
    def needs_server?
      @driver_options[:start_capybara_server]
    end
  end
end
