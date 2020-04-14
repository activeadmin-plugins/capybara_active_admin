# frozen_string_literal: true

module Capybara
  module ActiveAdmin
    module Selectors
      module Table
        def table_selector(model)
          return 'table.index_table' if model.nil?

          "table.index_table#index_table_#{model.to_s.pluralize}"
        end

        def table_row_selector(model, record_id)
          return 'tbody > tr' if record_id.nil?

          "tbody > tr##{model.to_s.singularize}_#{record_id}"
        end

        def table_header_selector
          'thead > tr > th.col'
        end

        def table_cell_selector(column)
          column = column.to_s.gsub(' ', '_').downcase unless column.nil?
          return 'td.col' if column.nil?

          "td.col.col-#{column}"
        end
      end
    end
  end
end
