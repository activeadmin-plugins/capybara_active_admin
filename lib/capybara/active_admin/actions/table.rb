# frozen_string_literal: true

module Capybara
  module ActiveAdmin
    module Actions
      module Table
        def select_table_row(id: nil, index: nil)
          raise ArgumentError, "can't use both :id and :index" if id && index
          raise ArgumentError, 'must provide :id or :index' if id.nil? && index.nil?

          if id
            find("input#batch_action_item_#{id}").click
            return
          end

          selector = %(input[id^="batch_action_item_"])
          find_all(selector, minimum: index + 1)[index].click
        end

        # @param text [String] exact text of the scope to click.
        def click_table_scope(text)
          selector = "#{table_scopes_container_selector} > #{table_scope_selector}"
          page.find(selector, exact_text: text).click
        end

        # @param text [String] column header text.
        # @param options [Hash] options passed to find_table_header.
        def click_table_header(text, options = {})
          find_table_header(text, options).find('a').click
        end
      end
    end
  end
end
