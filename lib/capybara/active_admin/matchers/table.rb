# frozen_string_literal: true

module Capybara
  module ActiveAdmin
    module Matchers
      module Table
        # @param options [Hash]
        #   :resource_name [String, nil] active admin page resource name
        #   for other options @see Capybara::RSpecMatchers#have_selector
        # @example
        #   expect(page).to have_table
        #   expect(page).to have_table(resource_name: 'users')
        #
        def have_table(options = {})
          resource_name = options.delete(:resource_name)
          selector = table_selector(resource_name)
          have_selector(selector, options)
        end

        # @param options [Hash]
        #   :text [String, nil] cell content
        #   :id [String, Number, nil] record ID
        #   for other options @see Capybara::RSpecMatchers#have_selector
        # @example
        #   within_table_for('users') do
        #     expect(page).to have_table_row(id: user.id)
        #   end
        #
        def have_table_row(options = {})
          row_id = options.delete(:id)
          selector = table_row_selector(current_table_model_name, row_id)
          have_selector(selector, options)
        end

        # @param options [Hash]
        #   :text [String, nil] cell content
        #   :column [String, nil] cell header name
        #   for other options @see Capybara::RSpecMatchers#have_selector
        # @example
        #   within_table_for('users') do
        #     within_table_row(id: user.id) do
        #       expect(page).to have_table_cell(count: 5)
        #       expect(page).to have_table_cell(text: user.id.to_s)
        #       expect(page).to have_table_cell(text: 'John Doe', column: 'Full name')
        #     end
        #   end
        #
        def have_table_cell(options = {})
          column = options.delete(:column)
          selector = table_cell_selector(column)

          have_selector(selector, options)
        end
      end
    end
  end
end
