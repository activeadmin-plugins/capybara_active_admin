# frozen_string_literal: true

module Capybara
  module ActiveAdmin
    module Actions
      # Actions for common Active Admin components.
      module Layout
        def click_action_item(title, options = {})
          within(action_items_container_selector) do
            click_link(title, options)
          end
        end

        def switch_tab(tab_name, options = {})
          opts = Util.options_with_text(tab_name, options)
          find(tab_header_link_selector, opts).click
        end

        def click_batch_action(title, exact: true)
          open_batch_action_menu
          within(dropdown_list_selector) do
            selector = batch_action_selector
            opts = Util.options_with_text(title, exact: exact)
            find(selector, opts).click
          end
        end

        def open_batch_action_menu
          return if find_all(dropdown_list_selector).present?

          find(batch_actions_button_selector).click
        end

        def confirm_modal_dialog
          within_modal_dialog { click_button 'OK' }
        end
      end
    end
  end
end
