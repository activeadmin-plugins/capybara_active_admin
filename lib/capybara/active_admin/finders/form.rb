# frozen_string_literal: true

module Capybara
  module ActiveAdmin
    module Finders
      module Form
        # @param name [Class<Object>, String] form record class or model name
        def within_form_for(name)
          name = name.model_name.singular if name.is_a?(Class)
          selector = form_selector(name)
          within(selector) { yield }
        end

        # @param association_name [String]
        # @param index [String] index of fieldset, starts with 0.
        # @yield within fieldset>ol
        def within_form_has_many(association_name, index: 0)
          selector = has_many_fields_selector(association_name)
          fieldset = find_all(selector, minimum: index + 1)[index]

          within(fieldset) { yield }
        end
      end
    end
  end
end
