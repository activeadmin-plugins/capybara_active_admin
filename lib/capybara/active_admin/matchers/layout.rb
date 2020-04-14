# frozen_string_literal: true

module Capybara
  module ActiveAdmin
    module Matchers
      module Layout
        def have_action_item(text, options = {})
          opts = options.merge(text: text)
          have_selector(action_item_selector, opts)
        end

        def have_page_title(text, options = {})
          opts = options.merge(text: text)
          have_selector(page_title_selector, opts)
        end

        def have_flash_message(text, options = {})
          type = options.delete(:type)
          opts = options.merge(text: text)
          selector = flash_message_selector(type)
          have_selector(selector, opts)
        end
      end
    end
  end
end
