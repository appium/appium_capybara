require_relative 'spec_helper'

describe 'UICatalog smoke test' do
  before(:each) do
    # ..
  end

  after(:each) do
    # ..
  end

  it 'should detect the nav bar' do
    @home_page = Pages::Home.new
    expect(@home_page.navigation_bar.displayed?).to be_truthy
  end
end