# frozen_string_literal: true

module Capybara
  module ActiveAdmin
    module Matchers
      module Form
        def have_form_error(text, options = {})
          field = options.delete(:field)
          opts = Util.options_with_text(text, options)
          li_selector = input_container_selector field, options.slice(:exact)

          have_selector("#{li_selector} #{inline_error_selector}", opts)
        end

        def have_no_form_errors(options = {})
          field = options.delete(:field)
          li_selector = input_container_selector field, options.slice(:exact)

          have_none_of_selectors(:css, "#{li_selector} #{inline_error_selector}", options)
        end

        def have_semantic_error(text, options = {})
          opts = Util.options_with_text(text, options)
          have_selector(semantic_error_selector, opts)
        end

        def have_semantic_errors(options = {})
          have_selector(semantic_error_selector, options)
        end

        def have_no_input(text, options = {})
          opts = Util.options_with_text(text, options)
          have_none_of_selectors(:css, label_selector, opts)
        end

        def have_has_many_fields_for(association_name, options = {})
          selector = has_many_fields_selector(association_name)
          have_selector(selector, options)
        end

        def have_input(text, options = {})
          selector = input_selector text, options.slice(:type, :text)
          opts = options.except(:type, :text)
          have_selector(selector, opts)
        end
      end
    end
  end
end
