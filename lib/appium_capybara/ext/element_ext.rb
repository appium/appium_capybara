class Capybara::Node::Element
  # Override
  def inspect
    %(#<Capybara::Node::Element name=#{@base.name}>)
  end
end
