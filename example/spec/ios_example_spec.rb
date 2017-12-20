require_relative 'spec_helper'

describe 'UICatalog smoke test' do
  it 'should detect the nav bar' do
    home_page = Pages::Home.new
    expect(home_page.navigation_bar.first).to be_truthy

    element = $driver.find_element :name, "Buttons"
    expect(element.name).to eq "Buttons"

    Appium.promote_appium_methods RSpec::ExampleGroups::UICatalogSmokeTest, $driver

    element = find_element :name, "Buttons"
    expect(element.name).to eq "Buttons"
  end
end
