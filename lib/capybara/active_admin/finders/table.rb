# frozen_string_literal: true

module Capybara
  module ActiveAdmin
    module Finders
      # Finders for *table_for*, it's rows and cells.
      module Table
        # @param resource_name [String, nil] resource name of index page.
        # @yield within table
        def within_table_for(resource_name = nil)
          selector = table_selector(resource_name)

          within(selector) { yield }
        end

        # id [String, Integer, nil] record ID.
        # index [Integer] row index in table (starts with 0).
        # @yield within table>tbody>tr
        def within_table_row(id: nil, index: nil)
          row = find_table_row(id: id, index: index)
          within(row) { yield }
        end

        def find_table_row(id: nil, index: nil)
          raise ArgumentError, "can't use both :id and :index" if id && index
          raise ArgumentError, 'must provide :id or :index' if id.nil? && index.nil?

          if id
            selector = table_row_selector(id)
            return find(selector)
          end

          selector = table_row_selector(nil)
          find_all(selector, minimum: index + 1)[index]
        end

        # @yield within table>tbody>tr>td
        def within_table_cell(name)
          cell = find_table_cell(name)
          within(cell) { yield }
        end

        def find_table_cell(column)
          selector = table_cell_selector(column)
          find(selector)
        end
      end
    end
  end
end
