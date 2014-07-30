module Capybara
  class Session
    def reset!
      # Next line is a work around for issue https://github.com/jnicklas/capybara/issues/1237
      if @touched && driver.browser_initialized?
        driver.reset!
        assert_no_selector(:xpath, "/html/body/*")
        @touched = false
      end
      raise_server_error!
    end
  end
end