require_relative 'spec_helper'

describe 'UICatalog smoke test' do
  it 'should detect the nav bar and get some methods' do
    home_page = Pages::Home.new
    expect(home_page.navigation_bar.first).to be_truthy

    expect(Capybara.current_driver).to be :appium

    capy_driver = Capybara.current_session.driver

    # Call appium driver's methods
    Capybara.current_session.driver.appium_driver.find_element(:name, 'Buttons').click
    Capybara.current_session.driver.appium_driver.wait do
      expect(capy_driver.find_custom(:class_name, 'XCUIElementTypeButton').size).to be 6
    end

    # Get Appium::Capybara::Node elements
    expect(capy_driver.find_custom(:name, 'X Button')[0].name).to eq('X Button')

    e = Capybara.current_session.find(:xpath, '//XCUIElementTypeNavigationBar')
    expect(e.find(:class, 'XCUIElementTypeButton').text).to eq('UICatalog')
  end
end
