# frozen_string_literal: true

module Capybara
  module ActiveAdmin
    module Matchers
      module AttributesTable
        def have_attributes_table(options = {})
          model_name = options.delete(:model)
          record_id = options.delete(:id)
          selector = attributes_table_selector(model_name, record_id)
          have_selector(selector, options)
        end

        def have_attribute_row(label, options = {})
          selector = attributes_row_selector(label)
          have_selector(selector, options)
        end
      end
    end
  end
end
