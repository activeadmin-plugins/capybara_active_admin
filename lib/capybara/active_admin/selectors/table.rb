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

        # @param text [String] column header text.
        # @param options [Hash]
        # @option column [String, nil] column name override (defaults to text).
        # @option sortable [Boolean] whether column is sortable.
        # @option sort_direction [String, nil] sort direction ('asc' or 'desc').
        # @return selector.
        def table_header_selector(text = nil, options = {})
          return 'thead > tr > th.col' if text.nil?

          column = (options[:column] || text).to_s.tr(' ', '_').downcase
          selector = "th.col.col-#{column}"
          selector += '.sortable' if options[:sortable]
          selector += ".sorted-#{options[:sort_direction].to_s.downcase}" if options[:sort_direction].present?
          "thead > tr > #{selector}"
        end

        # @param column [String, nil] column name.
        # @return selector.
        def table_cell_selector(column = nil)
          return 'td.col' if column.nil?

          column = column.to_s.gsub(' ', '_').downcase
          "td.col.col-#{column}"
        end

        def table_scopes_container_selector
          '.scopes > ul.table_tools_segmented_control'
        end

        def table_scope_selector
          'li.scope'
        end
      end
    end
  end
end
