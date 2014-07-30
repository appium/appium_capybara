module Capybara
  class Session
    attr_reader :touched
    alias_method :touched?, :touched

    def reset!
      return if Capybara.default_driver == :poltergeist
      if @touched
        driver.reset!
        # This is ugly and i know it
        assert_no_selector(:xpath, "/html/body/*") unless driver.instance_of?(Appium::Capybara::Driver)
        @touched = false
      end
      raise_server_error!
    end
  end
end