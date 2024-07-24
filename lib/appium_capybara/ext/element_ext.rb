class Capybara::Node::Element
  # Override
  def inspect
    return super unless @base.respond_to? :name
    # appium specific
    %(#<Capybara::Node::Element name=#{@base.name}>)
  end
end
