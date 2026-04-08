# frozen_string_literal: true

module Capybara
  module ActiveAdmin
    module Finders
      # Finders for common Active Admin components.
      module Layout
        def find_footer(options = {})
          selector = footer_selector
          have_selector(selector, **options)
        end

        def within_tab_body
          selector = tab_content_selector
          within(selector) { yield }
        end

        def within_sidebar(title, exact: nil)
          opts = Util.options_with_text(title, exact: exact)
          sidebar = page.find("#{sidebar_selector} .sidebar_section #{panel_title_selector}", **opts).ancestor('.sidebar_section')
          within(sidebar) { yield }
        end

        def within_panel(title, exact: nil)
          title_selector = "#{panel_selector} > #{panel_title_selector}"
          title_opts = Util.options_with_text(title, exact: exact)
          panel_title = find(title_selector, **title_opts)
          panel_content = panel_title.sibling(panel_content_selector)

          within(panel_content) { yield }
        end

        def within_modal_dialog
          within(modal_dialog_selector) { yield }
        end

        # @param title [String] action item link text.
        # @param exact [Boolean] whether to match the title exactly (default true).
        # @return [Capybara::Node::Element] the found action item element.
        def find_action_item(title, exact: true)
          opts = exact ? { exact_text: title } : { text: title }
          page.find(action_item_selector, **opts)
        end

        # @yield within action item dropdown menu list.
        def within_action_item_dropdown
          within("#{action_item_selector} .dropdown_menu_list_wrapper") { yield }
        end
      end
    end
  end
end
