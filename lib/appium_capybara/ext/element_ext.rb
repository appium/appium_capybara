class Capybara::Node::Element
  # Override
  def inspect
    %(#<#{self.class} tag="#{tag_name}" path="#{path}">)
  rescue ::Capybara::NotSupportedByDriverError, ::Selenium::WebDriver::Error::WebDriverError
    # Native context does not have the 'path' strategy, so it could raise an exception.
    # Then, the method can call tag_name instead.
    %(#<#{self.class} tag="#{tag_name}">)
  end
end
