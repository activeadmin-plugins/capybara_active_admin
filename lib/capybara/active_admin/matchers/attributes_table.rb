# frozen_string_literal: true

module Capybara
  module ActiveAdmin
    module Matchers
      module AttributesTable
        def have_attributes_table(options = {})
          model = options.delete(:model)
          id = options.delete(:id)
          selector = attributes_table_selector(model: model, id: id)
          have_selector(selector, **options)
        end

        def have_attribute_row(label, options = {})
          selector = attributes_row_selector(label)
          have_selector(selector, **options)
        end
      end
    end
  end
end
