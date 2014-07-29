class Capybara::Query < Capybara::Queries::BaseQuery
  # @api private
  def resolve_for(node, exact = nil)
    node.synchronize do
      children = if selector.format == :css
                   node.find_css(css)
                 elsif selector.format == :xpath
                   node.find_xpath(xpath(exact))
                 else
                   node.find_custom(selector.format, locator)
                 end.map do |child|
        if node.is_a?(Capybara::Node::Base)
          Capybara::Node::Element.new(node.session, child, node, self)
        else
          Capybara::Node::Simple.new(child)
        end
      end
      Capybara::Result.new(children, self)
    end
  end
end
