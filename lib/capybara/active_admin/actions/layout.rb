# frozen_string_literal: true

module Capybara
  module ActiveAdmin
    module Actions
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

        def click_batch_action(title)
          find(batch_actions_button_selector).click
          within(dropdown_list_selector) do
            selector = batch_action_selector(title)
            find(selector).click
          end
        end

        def confirm_modal_dialog
          within_modal_dialog { click_button 'OK' }
        end
      end
    end
  end
end
