# frozen_string_literal: true

module Capybara
  module ActiveAdmin
    module Finders
      # Finders for *active_admin_form_for* and related form components.
      module Form
        # @param model_name [Class<Object>, String, nil] form record class or model name (default nil).
        # @yield within form
        def within_form_for(model_name = nil)
          selector = form_selector(model_name)
          within(selector) { yield }
        end

        # @param association_name [String]
        # @param index [String] index of fieldset, starts with 0 (default 0).
        # @yield within fieldset>ol
        def within_form_has_many(association_name, index: 0)
          selector = has_many_fields_selector(association_name)
          fieldset = find_all(selector, minimum: index + 1)[index]

          within(fieldset) { yield }
        end

        # @param association_name [String]
        # @yield within container have_many by passed association_name
        def within_has_many(association_name)
          selector = has_many_container_selector(association_name)
          fieldset = find(selector)

          within(fieldset) { yield }
        end

        # @yield within filters container.
        def within_filters
          selector = filter_form_selector
          within(selector) { yield }
        end
      end
    end
  end
end
