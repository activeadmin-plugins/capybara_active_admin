# frozen_string_literal: true

module Capybara
  module ActiveAdmin
    module Finders
      module AttributesTable
        # @param model_name [Class<Object>, nil] model name or class.
        # @param record_id [String, Numeric, nil]
        # @yield within attributes table
        def within_attributes_table_for(model_name, record_id = nil)
          selector = attributes_table_selector(model_name, record_id)
          within(selector) { yield }
        end

        def within_attribute_row(label)
          selector = attributes_row_selector(label)
          within(selector) { yield }
        end
      end
    end
  end
end
