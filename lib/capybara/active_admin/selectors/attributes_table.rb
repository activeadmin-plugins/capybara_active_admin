# frozen_string_literal: true

require 'capybara/active_admin/util'

module Capybara
  module ActiveAdmin
    module Selectors
      module AttributesTable
        # @return [String] selector.
        def attributes_table_selector(model: nil, id: nil)
          return 'div.attributes_table' if model.nil?

          model = Util.parse_model_name(model)
          selector = "div.attributes_table.#{model}"
          selector += "#attributes_table_#{model}_#{id}" if id
          selector
        end

        # @return [String] selector.
        def attributes_row_selector(label = nil)
          return 'tr.row > td' if label.nil?

          label = Util.css_class_for_label(label)
          "tr.row.row-#{label} > td"
        end
      end
    end
  end
end
