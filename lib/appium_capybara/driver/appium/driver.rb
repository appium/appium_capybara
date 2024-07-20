module Appium::Capybara
  # methods in this class either override selenium driver methods
  # or they're new and specific to appium.
  class Appium::Capybara::Driver < Capybara::Selenium::Driver

    # new
    #
    # starts new driver
    def appium_driver
      # must use self to reference the 'browser' method
      browser unless @appium_driver

      @appium_driver
    end

    # override
    #
    # Creates and starts a new appium driver.
    # To access the browser without creating one use @browser
    def browser
      return @browser if @browser

      @appium_driver = Appium::Driver.new @options, false
      # browser is the standard selenium driver without any appium methods
      @browser = @appium_driver.start_driver

      main = Process.pid
      at_exit do
        # Store the exit status of the test run since it goes away after calling the at_exit proc...
        @exit_status = $ERROR_INFO.status if $ERROR_INFO.is_a?(SystemExit)
        quit if Process.pid == main
        exit @exit_status if @exit_status # Force exit with stored status
      end
      @browser
    end

    # override
    def find_xpath(selector)
      appium_driver.find_elements(:xpath, selector).map { |node| Appium::Capybara::Node.new(self, node) }
    end

    # override
    def find_css(selector)
      appium_driver.find_elements(:css, selector).map { |node| Appium::Capybara::Node.new(self, node) }
    end

    # override
    def reset!
      # invoking the browser method after the browser has closed will cause it to relaunch
      # use @appium_driver to avoid the relaunch.
      @appium_driver.reset if @appium_driver
    end

    # @deprecated This method is being removed
    def browser_initialized?
      !!@browser
    end

    # override
    # type and options are passed but can be ignored.
    def dismiss_modal(type, options = {}, &blk)
      appium_driver.alert_dismiss
    end

    # override
    # type and options are passed but can be ignored.
    def accept_modal(type, options = {}, &blk)
      appium_driver.alert_accept
    end

    # new
    def scroll_up
      browser.execute_script('mobile: scroll', direction: 'up')
    end

    # new
    def scroll_down
      browser.execute_script('mobile: scroll', direction: 'down')
    end

    # new
    def swipe(opts)
      start_x = opts.fetch :start_x, 0
      start_y = opts.fetch :start_y, 0
      end_x   = opts.fetch :end_x, 0
      end_y   = opts.fetch :end_y, 0
      duration = opts.fetch :duration, 200

      action_builder = browser.action
      input = action_builder.pointer_inputs[0]
      action_builder
        .move_to_location(start_x, start_y)
        .pointer_down(:left)
        .pause(device: input, duration: duration / 1000)
        .move_to_location(end_x, end_y)
        .pause(device: input, duration: 1)
        .release
        .perform
    end

    # new
    # Use :landscape or :portrait
    def rotate(opts)
      browser.rotate opts
    end

    # override
    # Capybara always passes an options param but appium_lib can't do anything with it.
    def save_screenshot(path, options = {})
      appium_driver.screenshot path if @appium_driver
    end

    # new
    def find_custom(finder, locator)
      appium_driver.find_elements(finder, locator).map { |node| Appium::Capybara::Node.new(self, node) }
    end

    # override
    def quit
      @appium_driver.driver_quit if @browser || @appium_driver
    rescue Errno::ECONNREFUSED
      # Browser must have already gone
    ensure
      @browser = nil
      @appium_driver = nil
    end

  end # Appium::Capybara::Driver < Capybara::Selenium::Driver
end # Appium::Capybara
