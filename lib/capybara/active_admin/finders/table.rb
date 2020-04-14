# frozen_string_literal: true

module Capybara
  module ActiveAdmin
    module Finders
      module Table
        def current_table_name
          @__current_table_name
        end

        def within_table_for(name)
          name = name.model_name.plural if name.is_a?(Class)
          selector = table_selector(name)

          within(selector) do
            old = @__current_table_name
            @__current_table_name = name
            begin
              yield
            ensure
              @__current_table_name = old
            end
          end
        end

        def within_table_row(id: nil, index: nil)
          row = find_table_row(id: id, index: index)
          within(row) { yield }
        end

        def find_table_row(id: nil, index: nil)
          raise ArgumentError, "can't use both :id and :index" if id && index
          raise ArgumentError, 'must provide :id or :index' if id.nil? && index.nil?

          if id
            model = @__current_table_name
            selector = table_row_selector(model, id)
            return find(selector)
          end

          find_all(table_row_selector(nil, nil), minimum: index + 1)[index]
        end

        def within_table_cell(name)
          cell = find_table_cell(name)
          within(cell) { yield }
        end

        def find_table_cell(column)
          selector = table_cell_selector(column)
          find(selector)
        end
      end
    end
  end
end
