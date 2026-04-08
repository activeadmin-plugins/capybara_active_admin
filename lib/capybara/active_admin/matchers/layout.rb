# frozen_string_literal: true

module Capybara
  module ActiveAdmin
    module Matchers
      # Matchers for common Active Admin components.
      module Layout
        def have_action_item(text, options = {})
          opts = Util.options_with_text(text, options)
          have_selector(action_item_selector, **opts)
        end

        def have_page_title(text, options = {})
          opts = Util.options_with_text(text, options)
          have_selector(page_title_selector, **opts)
        end

        def have_flash_message(text, options = {})
          type = options.delete(:type)
          opts = Util.options_with_text(text, options)
          selector = flash_message_selector(type)
          have_selector(selector, **opts)
        end

        def have_footer(options = {})
          selector = footer_selector
          have_selector(selector, **options)
        end

        def have_panel(title, options = {})
          title_selector = "#{panel_selector} > #{panel_title_selector}"
          opts = Util.options_with_text(title, options)
          have_selector(title_selector, **opts)
        end

        def have_sidebar(title, options = {})
          title_selector = "#{sidebar_selector} #{panel_selector} > #{panel_title_selector}"
          opts = Util.options_with_text(title, options)
          have_selector(title_selector, **opts)
        end

        def have_batch_action(title, exact: true)
          selector = "#{dropdown_list_selector} #{batch_action_selector}"
          opts = Util.options_with_text(title, exact: exact)
          have_selector(selector, **opts)
        end

        # @param title [String] action item link text.
        # @param exact [Boolean] whether to match the title exactly (default true).
        # @param href [String, nil] expected href attribute of the link.
        # @param options [Hash] additional options passed to have_selector.
        # @example
        #   expect(page).to have_action_item_link('New User')
        #   expect(page).to have_action_item_link('New User', href: new_admin_user_path)
        #
        def have_action_item_link(title, exact: true, href: nil, **options)
          opts = exact ? { exact_text: title } : { text: title }
          opts.merge!(options)
          selector = "#{action_item_selector} > a"
          selector += "[href=\"#{href}\"]" if href.present?
          have_selector(selector, **opts)
        end

        # @param type [String, Symbol] status tag type (e.g. :yes, :no, :warning).
        # @param options [Hash] additional options passed to have_selector (e.g. exact_text:).
        # @example
        #   expect(page).to have_status_tag(:yes)
        #   expect(page).to have_status_tag(:error, exact_text: 'DOWN')
        #
        def have_status_tag(type, **options)
          have_selector("span.status_tag.#{type}", **options)
        end
      end
    end
  end
end
