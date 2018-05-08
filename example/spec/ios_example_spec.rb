require_relative 'spec_helper'

describe 'UICatalog smoke test' do
  it 'should detect the nav bar and get some methods' do
    home_page = Pages::Home.new
    expect(home_page.navigation_bar.first).to be_truthy

    expect(Capybara.current_driver).to be :appium

    capy_driver = Capybara.current_session.driver

    # Call appium driver's methods
    capy_driver.appium_driver.find_element(:name, 'TextFields').click
    expect(capy_driver.find_custom(:name, '<enter text>').size).to be 3

    # Get Appium::Capybara::Node elements
    capy_driver.find_custom(:name, '<enter text>')[0].send_keys 'abc'
  end
end
