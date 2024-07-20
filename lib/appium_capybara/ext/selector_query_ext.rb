class Capybara::Queries::SelectorQuery < Capybara::Queries::BaseQuery
  private

  # https://github.com/teamcapybara/capybara/blob/a7ebe1216f8d65f2e96c170437a732777353a81d/lib/capybara/queries/selector_query.rb#L227
  def find_nodes_by_selector_format(node, exact)
    hints = {}
    hints[:uses_visibility] = true unless visible == :all
    hints[:texts] = text_fragments unless selector_format == :xpath
    hints[:styles] = options[:style] if use_default_style_filter?
    hints[:position] = true if use_spatial_filter?

    case selector_format
    when :css
      if node.method(:find_css).arity != 1
        node.find_css(css, **hints)
      else
        node.find_css(css)
      end
    when :xpath
      if node.method(:find_xpath).arity != 1
        node.find_xpath(xpath(exact), **hints)
      else
        node.find_xpath(xpath(exact))
      end
    else
      node.find_custom(selector_format, @expression)
    end
  end
end
