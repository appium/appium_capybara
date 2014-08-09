module Capybara
  class Session
    def reset!
      # Next line is a work around for issue https://github.com/jnicklas/capybara/issues/1237
      if @touched && driver.browser_initialized?
        driver.reset!
        # Ugly hack to not run this assertion for Appium
        assert_no_selector(:xpath, "/html/body/*") unless driver.instance_of? Appium::Capybara::Driver
        @touched = false
      end
      raise_server_error!
    end
  end
end