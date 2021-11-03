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

    Capybara.current_session.driver.appium_driver.back

    capy_driver.swipe({start_x: 100, start_y: 500, end_x: 100, end_y: 200})
    Capybara.current_session.driver.appium_driver.find_element(:name, 'Text Fields').click

    e = capy_driver.find_custom(:predicate, 'value == "Placeholder text"').first
    e.send_keys [:shift, :end]

    e = Capybara.current_session.find(:xpath, '//XCUIElementTypeTextField[@value=""]')
    e.send_keys [:shift, :end]

    expect(e.text).to eq("")


    Capybara.current_session.driver.appium_driver.back

    sleep 1
    capy_driver.scroll_down
    sleep 1
    capy_driver.scroll_up
    Capybara.current_session.driver.appium_driver.find_element(:name, 'Text Fields').click
  end
end
