module Capybara
  class Session
    def reset!
      # Work around for issue https://github.com/jnicklas/capybara/issues/1237
      browser_initialized = driver.respond_to?(:browser_initialized?) ? driver.browser_initialized? : true

      if @touched && browser_initialized
        driver.reset!
        # Ugly hack to not run this assertion for Appium
        assert_no_selector(:xpath, "/html/body/*") unless driver.instance_of? Appium::Capybara::Driver
        @touched = false
      end
      raise_server_error!
    end
  end
end