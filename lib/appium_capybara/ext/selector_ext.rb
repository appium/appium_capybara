module Capybara
  class Selector

    def custom(f, &block)
      @format, @expression = f, block if block
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
Capybara.add_selector(:accessibility_id) do
  custom(:accessibility_id) { |locator| locator }
end
Capybara.add_selector(:custom) do
  custom(:custom) { |locator| locator }
end
