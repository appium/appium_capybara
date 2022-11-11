module Pages
  class Home < ::SitePrism::Page
    # UIANavigationBar
    #   name: UICatalog
    elements :navigation_bar, :accessibility_id, 'UICatalog'

    section :action_sheets_section, Sections::Sheets, :name, 'Action Sheets'
  end
end
