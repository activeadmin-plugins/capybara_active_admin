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
          selector = sidebar_selector

          within(selector) do
            within_panel(title, exact: exact) { yield }
          end
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
      end
    end
  end
end
