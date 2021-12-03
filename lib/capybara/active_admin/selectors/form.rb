# frozen_string_literal: true

module Capybara
  module ActiveAdmin
    module Selectors
      # Selectors for *active_admin_form_for* and related form components.
      module Form
        # @param model_name [String, nil] form model name
        # @return [String] selector.
        def form_selector(model_name = nil)
          return 'form.formtastic' if model_name.nil?

          model_name = Util.parse_model_name(model_name, singular: true)
          "form.formtastic.#{model_name}"
        end

        # @return [String] selector.
        def label_selector
          'label.label'
        end

        # @return [String] selector.
        def inline_error_selector
          'p.inline-errors'
        end

        # @return [String] selector.
        def semantic_error_selector
          'ul.errors > li'
        end

        # @param association_name [String]
        # @return [String] selector.
        def has_many_fields_selector(association_name)
          "div.has_many_container.#{association_name} > fieldset.inputs.has_many_fields"
        end

        # @param association_name [String]
        # @return [String] .has_many_container selector.
        def has_many_container_selector(association_name)
          ".has_many_container.#{association_name}"
        end

        # @param text [String, nil] submit button text.
        # @return [String] selector.
        def form_submit_selector(text = nil)
          return %(input[type="submit"]) if text.nil?

          %(input[type="submit"][value="#{text}"])
        end

        # @param label [String, nil] field label.
        # @param exact [Boolean, nil] match by exact label text (default false).
        # @return [String] selector.
        def input_container_selector(label = nil, exact: nil)
          return 'li' if label.nil?

          label_opts = Util.options_with_text(label, exact: exact)
          label_node = find(label_selector, **label_opts)
          li_id = label_node.ancestor('li')[:id]
          "li##{li_id}"
        end

        # @return [String] selector.
        def filter_form_selector
          '.filter_form'
        end
      end
    end
  end
end
