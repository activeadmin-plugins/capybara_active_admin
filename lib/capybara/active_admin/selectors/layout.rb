# frozen_string_literal: true

module Capybara
  module ActiveAdmin
    module Selectors
      # Selectors for common Active Admin components.
      module Layout
        # @return [String] selector.
        def action_items_container_selector
          '#titlebar_right .action_items'
        end

        # @return [String] selector.
        def action_item_selector
          "#{action_items_container_selector} .action_item"
        end

        # @return [String] selector.
        def page_title_selector
          '#page_title'
        end

        # @return [String] selector.
        def flash_message_selector(type = nil)
          return ".flashes .flash.flash_#{type}" if type

          '.flashes .flash'
        end

        # @return [String] selector.
        def footer_selector
          'div.footer#footer'
        end

        # @return [String] selector.
        def tab_header_link_selector
          '.tabs.ui-tabs li.ui-tabs-tab a'
        end

        # @return [String] selector.
        def tab_content_selector
          '.tab-content'
        end

        # @return [String] selector.
        def sidebar_selector
          '#sidebar'
        end

        # @return [String] selector.
        def panel_selector
          '.panel'
        end

        # @return [String] selector.
        def panel_title_selector
          'h3'
        end

        # @return [String] selector.
        def panel_content_selector
          '.panel_contents'
        end

        # @return [String] selector.
        def batch_actions_button_selector
          'div.batch_actions_selector'
        end

        # @return [String] selector.
        def dropdown_list_selector
          'ul.dropdown_menu_list'
        end

        # @return [String] selector.
        def batch_action_selector
          'li a[data-action]'
        end

        # @return [String] selector.
        def modal_dialog_selector
          '.active_admin_dialog'
        end
      end
    end
  end
end
