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
      end
    end
  end
end
