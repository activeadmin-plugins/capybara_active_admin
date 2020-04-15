# frozen_string_literal: true

module Capybara
  module ActiveAdmin
    module Matchers
      module Layout
        def have_action_item(text, options = {})
          opts = Util.options_with_text(text, options)
          have_selector(action_item_selector, opts)
        end

        def have_page_title(text, options = {})
          opts = Util.options_with_text(text, options)
          have_selector(page_title_selector, opts)
        end

        def have_flash_message(text, options = {})
          type = options.delete(:type)
          opts = Util.options_with_text(text, options)
          selector = flash_message_selector(type)
          have_selector(selector, opts)
        end

        def have_footer(options = {})
          selector = footer_selector
          have_selector(selector, options)
        end

        def have_panel(title, options = {})
          title_selector = "#{panel_selector} > #{panel_title_selector}"
          opts = Util.options_with_text(title, options)
          have_selector(title_selector, opts)
        end

        def have_sidebar(title, options = {})
          title_selector = "#{sidebar_selector} #{panel_selector} > #{panel_title_selector}"
          opts = Util.options_with_text(title, options)
          have_selector(title_selector, opts)
        end
      end
    end
  end
end
