# frozen_string_literal: true

module Capybara
  module ActiveAdmin
    module Selectors
      # Selectors for *table_for*, it's rows and cells.
      module Table
        # @param resource_name [String, nil] active admin resource name.
        # @return selector.
        def table_selector(resource_name = nil)
          return 'table.index_table' if resource_name.nil?

          resource_name = resource_name.to_s.gsub(' ', '_').pluralize.downcase
          "table#index_table_#{resource_name}"
        end

        # @param record_id [String, Integer, nil] record ID.
        # @return selector.
        def table_row_selector(record_id = nil)
          return 'tbody > tr' if record_id.nil?

          %(tbody > tr[id$="_#{record_id}"])
        end

        # @return selector.
        def table_header_selector
          'thead > tr > th.col'
        end

        # @param column [String, nil] column name.
        # @return selector.
        def table_cell_selector(column = nil)
          return 'td.col' if column.nil?

          column = column.to_s.gsub(' ', '_').downcase
          "td.col.col-#{column}"
        end
      end
    end
  end
end
