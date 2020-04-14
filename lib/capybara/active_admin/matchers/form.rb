# frozen_string_literal: true

module Capybara
  module ActiveAdmin
    module Matchers
      module Form
        def have_form_error(error, options = {})
          field = options.delete(:field)
          opts = options.merge(text: error)
          return have_selector("li #{inline_error_selector}", opts) if field.nil?

          label = find(label_selector, text: field)
          li_id = label.ancestor('li')[:id]
          have_selector("li##{li_id} #{inline_error_selector}", opts)
        end

        def have_no_form_errors(options = {})
          field = options.delete(:field)
          return have_none_of_selectors(:css, "li #{inline_error_selector}", options) if field.nil?

          label = find(label_selector, text: field)
          li_id = label.ancestor('li')[:id]
          have_none_of_selectors(:css, "li##{li_id} #{inline_error_selector}", options)
        end

        def have_semantic_error(error, options = {})
          opts = options.merge(text: error)
          have_selector(semantic_error_selector, opts)
        end

        def have_semantic_errors(options = {})
          have_selector(semantic_error_selector, options)
        end

        def have_no_input(label, options = {})
          opts = options.merge(text: label)
          have_none_of_selectors(:css, label_selector, opts)
        end

        def have_has_many_fields_for(association_name, options = {})
          selector = has_many_fields_selector(association_name)
          have_selector(selector, options)
        end

        def have_input(label, options = {})
          selector = input_selector label, options.slice(:type, :text)
          opts = options.except(:type, :text)
          have_selector(selector, opts)
        end
      end
    end
  end
end
