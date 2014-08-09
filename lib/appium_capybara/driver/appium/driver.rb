module Appium::Capybara
  # methods in this class either override selenium driver methods
  # or they're new and specific to appium.
  class Appium::Capybara::Driver < Capybara::Selenium::Driver

    # override
    #
    # Creates and starts a new appium driver.
    # To access the browser without creating one use @browser
    def browser
      unless @browser
        @browser = Appium::Driver.new @options
        # This will fail if your appium didn't close its last session
        @browser.start_driver
      end
      @browser
    end

    # override
    def find_xpath(selector)
      browser.find_elements(:xpath, selector).map { |node| Appium::Capybara::Node.new(self, node) }
    end

    # override
    def find_css(selector)
      browser.find_elements(:css, selector).map { |node| Appium::Capybara::Node.new(self, node) }
    end

    # override
    def reset!
      # invoking the browser method after the browser has closed will cause it to relaunch
      # use @browser to avoid the relaunch.
      @browser.driver.reset if @browser
    end

    # new
    def browser_initialized?
      !! @browser
    end

    # new
    def dismiss_alert
      browser.alert_dismiss
    end

    # new
    def accept_alert
      browser.alert_accept
    end

    # new
    def scroll_up
      browser.driver.execute_script("mobile: scroll", direction: "up")
    end

    # new
    def scroll_down
      browser.driver.execute_script("mobile: scroll", direction: "down")
    end

    # new
    # Use :landscape or :portrait
    def rotate(opts)
      browser.driver.rotate opts
    end

    # new
    def find_custom(finder, locator)
      browser.find_elements(finder, locator).map { |node| Appium::Capybara::Node.new(self, node) }
    end

    # override
    def quit
      @browser.driver_quit if @browser
    rescue Errno::ECONNREFUSED
      # Browser must have already gone
    ensure
      @browser = nil
    end

  end # Appium::Capybara::Driver < Capybara::Selenium::Driver
end # Appium::Capybara
