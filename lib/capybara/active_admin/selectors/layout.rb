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
      end
    end
  end
end
