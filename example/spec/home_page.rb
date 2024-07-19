module Pages
  class Home < ::SitePrism::Page
    # UIANavigationBar
    #   name: UICatalog
    elements :navigation_bar, :accessibility_id, 'UIKitCatalog'

    section :action_sheets_section, Sections::Sheets, :name, 'Alert Views'
  end
end
