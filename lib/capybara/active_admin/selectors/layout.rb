# frozen_string_literal: true

module Capybara
  module ActiveAdmin
    module Selectors
      module Layout
        def action_items_container_selector
          '#titlebar_right .action_items'
        end

        def action_item_selector
          "#{action_items_container_selector} .action_item"
        end

        def page_title_selector
          '#page_title'
        end

        def flash_message_selector(type = nil)
          return ".flashes .flash.flash_#{type}" if type

          '.flashes .flash'
        end

        def footer_selector
          'div.footer#footer'
        end

        def tab_header_link_selector
          '.tabs.ui-tabs li.ui-tabs-tab a'
        end

        def tab_content_selector
          '.tab-content'
        end

        def sidebar_selector
          '#sidebar'
        end

        def panel_selector
          '.panel'
        end

        def panel_title_selector
          'h3'
        end

        def panel_content_selector
          '.panel_contents'
        end

        def batch_actions_button_selector
          'div.batch_actions_selector'
        end

        def dropdown_list_selector
          'ul.dropdown_menu_list'
        end

        def batch_action_selector(title)
          "li a[data-action='#{title}']"
        end

        def modal_dialog_selector
          '.active_admin_dialog'
        end
      end
    end
  end
end
