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
          have_selector(selector, **options)
        end

        # @param options [Hash]
        #   :text [String, nil] cell content
        #   :exact_text [String, nil] cell content exact matching
        #   :id [String, Number, nil] record ID
        #   for other options @see Capybara::RSpecMatchers#have_selector
        # @example
        #   within_table_for('users') do
        #     expect(page).to have_table_row(id: user.id)
        #   end
        #
        def have_table_row(options = {})
          row_id = options.delete(:id)
          selector = table_row_selector(row_id)
          have_selector(selector, **options)
        end

        # @param options [Hash]
        #   :text [String, nil] cell content include matching
        #   :exact_text [String, nil] cell content exact matching
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

          have_selector(selector, **options)
        end

        # @param options [Hash]
        # @option count [Integer] qty of nodes
        def have_table_scopes(options = {})
          have_selector("#{table_scopes_container_selector} > #{table_scope_selector}", **options)
        end

        # @param title [String, nil] exact title of scope to match.
        # @param selected [Boolean] whether to match selected (active) scope only (default false).
        # @param options [Hash] additional options passed to have_selector.
        def have_table_scope(title = nil, selected: false, **options)
          selector = "#{table_scopes_container_selector} > #{table_scope_selector}"
          if title.nil?
            selector = selected ? "#{selector}.selected" : "#{selector}:not(.selected)"
            have_selector(selector, **options)
          else
            selector = selected ? "#{selector}.selected" : selector
            have_selector(selector, exact_text: title.to_s, **options)
          end
        end

        # @param text [String] column header text.
        # @param options [Hash]
        # @option column [String, nil] column name override (defaults to text).
        # @option sortable [Boolean] whether the column is sortable.
        # @option sort_direction [String, nil] sort direction ('asc' or 'desc').
        # @example
        #   expect(page).to have_table_header('Full Name')
        #   expect(page).to have_table_header('Full Name', sortable: true)
        #   expect(page).to have_table_header('Full Name', sort_direction: :asc)
        #
        def have_table_header(text, options = {})
          selector = table_header_selector(text, options)
          opts = options.except(:column, :sortable, :sort_direction).merge(exact_text: text)
          have_selector(selector, **opts)
        end
      end
    end
  end
end
