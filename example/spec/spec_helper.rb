require_relative 'capybara_init'

# sections
require_relative 'sheets_section'
# pages
require_relative 'home_page'

RSpec.configure do |config|
  config.after(:each) { Capybara.current_session.driver.quit }

  config.after do |result|
    Capybara.current_session.driver.save_screenshot 'error.png' if result.exception
  end
end
