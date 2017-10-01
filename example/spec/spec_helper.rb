require_relative 'capybara_init'

# pages
require_relative 'home_page'

RSpec.configure do |config|
  config.after(:each) do |result|
    Capybara.current_session.driver.quit
  end

  config.after do |result|
    Capybara.current_session.driver.save_screenshot 'error.png' if result.exception
  end
end