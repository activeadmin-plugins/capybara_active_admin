# frozen_string_literal: true

module Capybara
  module ActiveAdmin
    module Selectors
      module AttributesTable
        def attributes_table_selector(model_name, record_id = nil)
          return 'div.attributes_table' if model_name.nil?

          model_name = Util.parse_model_name(model_name)
          selector = "div.attributes_table.#{model_name}"
          selector += "#attributes_table_#{model_name}_#{record_id}" if record_id
          selector
        end

        def attributes_row_selector(label)
          return 'tr.row > td' if label.nil?

          label = label.to_s.gsub(' ', '_').downcase
          "tr.row.row-#{label} > td"
        end
      end
    end
  end
end
