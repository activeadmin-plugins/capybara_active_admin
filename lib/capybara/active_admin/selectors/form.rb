# frozen_string_literal: true

module Capybara
  module ActiveAdmin
    module Selectors
      module Form
        # @param name [String] form model name
        def form_selector(name)
          "form.formtastic.#{name}"
        end

        def label_selector
          'label.label'
        end

        def inline_error_selector
          'p.inline-errors'
        end

        def semantic_error_selector
          'ul.errors > li'
        end

        def has_many_fields_selector(association_name)
          "div.has_many_container.#{association_name} > fieldset.inputs.has_many_fields"
        end

        def form_submit_selector(value = nil)
          selector = %(input[type="submit"])
          selector += %([value="#{value}"]) unless value.nil?
          selector
        end

        def input_container_selector(label, exact: nil)
          return 'li' if label.nil?

          label_opts = Util.options_with_text(label, exact: exact)
          label_node = find(label_selector, label_opts)
          li_id = label_node.ancestor('li')[:id]
          "li##{li_id}"
        end

        def filter_form_selector
          '.filter_form'
        end
      end
    end
  end
end
