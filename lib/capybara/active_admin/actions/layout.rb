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
      end
    end
  end
end
