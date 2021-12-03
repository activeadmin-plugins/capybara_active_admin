# frozen_string_literal: true

module Capybara
  module ActiveAdmin
    module Matchers
      module Form
        def have_form_error(text, options = {})
          field = options.delete(:field)
          opts = Util.options_with_text(text, options)
          li_selector = input_container_selector field, **options.slice(:exact)

          have_selector("#{li_selector} #{inline_error_selector}", **opts)
        end

        def have_no_form_errors(options = {})
          field = options.delete(:field)
          li_selector = input_container_selector field, **options.slice(:exact)

          have_none_of_selectors(:css, "#{li_selector} #{inline_error_selector}", **options)
        end

        def have_semantic_error(text, options = {})
          opts = Util.options_with_text(text, options)
          have_selector(semantic_error_selector, **opts)
        end

        def have_semantic_errors(options = {})
          have_selector(semantic_error_selector, **options)
        end

        def have_has_many_fields_for(association_name, options = {})
          selector = has_many_fields_selector(association_name)
          have_selector(selector, **options)
        end

        # @param text [String] button title
        # @param options [Hash]
        # @option selector [String, nil] optional selector to append
        # @option disabled [Boolean] button disabled or not (default false)
        # @example
        #   expect(page).to have_submit_input('Submit') # check that submit input is present
        #   expect(page).to have_submit_input('Submit', selector: '.custom-class') # check custom class presence
        #   expect(page).to have_submit_input('Submit', disabled: true) # check that submit input is disabled
        #   expect(page).to have_submit_input('Submit', disabled: true, count: 0) # check that submit input is enabled
        #
        def have_submit_input(text, options = {})
          selector = "#{form_submit_selector(text)}#{options.delete(:selector)}"
          selector += '[disabled="disabled"].disabled' if options.delete(:disabled)
          have_selector(selector, **options)
        end
      end
    end
  end
end
