# frozen_string_literal: true

module Capybara
  module ActiveAdmin
    module Selectors
      module Table
        def table_selector(resource_name)
          return 'table.index_table' if resource_name.nil?

          resource_name = resource_name.to_s.gsub(' ', '_').pluralize.downcase
          "table#index_table_#{resource_name}"
        end

        def table_row_selector(model_name, record_id)
          return 'tbody > tr' if record_id.nil?

          model_name = Util.parse_model_name(model_name)
          "tbody > tr##{model_name}_#{record_id}"
        end

        def table_header_selector
          'thead > tr > th.col'
        end

        def table_cell_selector(column)
          return 'td.col' if column.nil?

          column = column.to_s.gsub(' ', '_').downcase
          "td.col.col-#{column}"
        end
      end
    end
  end
end
