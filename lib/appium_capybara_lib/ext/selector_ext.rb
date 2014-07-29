module Capybara
  class Selector
    def custom(f, &block)
      @format = f
      @custom = block if block
      @custom
    end

    def call(locator)
      if @format == :css
        @css.call(locator)
      elsif @format == :xpath
        @xpath.call(locator)
      else
        @custom.call(locator)
      end
    end
  end
end

Capybara.add_selector(:id) do
  custom(:id) { |locator| locator }
end
Capybara.add_selector(:class) do
  custom(:class) { |locator| locator }
end
Capybara.add_selector(:name) do
  custom(:name) { |locator| locator }
end