# frozen_string_literal: true

module Capybara
  module ActiveAdmin
    module Finders
      # Finder methods for ActiveAdmin attributes_table_for can be found here.
      # @see Capybara::ActiveAdmin::Finders base finders module.
      module AttributesTable
        # Calls block within attributes table.
        # @param model [Class<Object>, nil] model name or class.
        # @param id [String, Numeric, nil] record ID.
        # @yield within attributes table.
        def within_attributes_table_for(model: nil, id: nil)
          selector = attributes_table_selector(model: model, id: id)
          within(selector) { yield }
        end

        # Calls block within attributes table row.
        # @param label [String] row label.
        # @yield within attributes table.
        def within_attribute_row(label)
          selector = attributes_row_selector(label)
          within(selector) { yield }
        end
      end
    end
  end
end
