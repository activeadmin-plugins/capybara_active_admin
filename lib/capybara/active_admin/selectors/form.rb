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

        def input_selector(label, options)
          text = options.delete(:text)
          type = options.delete(:type) || :text

          label_opts = options.merge(text: label)
          label = find(label_selector, label_opts)

          input_id = label[:for]
          tag_name = type.to_sym == :select ? 'select' : 'input'
          selector = "#{tag_name}##{input_id}"
          selector = %(#{selector}[value="#{text}"]) unless text.nil?
          selector
        end
      end
    end
  end
end
