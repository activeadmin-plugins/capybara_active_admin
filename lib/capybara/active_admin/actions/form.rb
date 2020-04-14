# frozen_string_literal: true

module Capybara
  module ActiveAdmin
    module Actions
      module Form
        def click_submit(value, options = {})
          selector = form_submit_selector(value)
          find(selector, options).click
        end

        def fill_in_file(label, options = {})
          path = options.delete(:with)
          attach_file(label, path)
        end
      end
    end
  end
end
