module ActiveAdminRspec
  module SystemTestMatchers
    def have_action_item(text, options = {})
      opts = options.merge(text: text)
      have_selector('#titlebar_right .action_items .action_item', opts)
    end

    def click_action_item(title, options = {})
      within '#titlebar_right .action_items' do
        click_link(title, options)
      end
    end

    def have_page_title(text, options = {})
      opts = options.merge(text: text)
      have_selector('#page_title', opts)
    end

    def have_flash_message(text, options = {})
      type = options.delete(:type)
      opts = options.merge(text: text)
      if type
        selector = ".flashes .flash.flash_#{type}"
      else
        selector = '.flashes .flash'
      end
      have_selector(selector, opts)
    end

    def have_table_row(options = {})
      model = options.delete(:model)
      row_id = options.delete(:row_id)
      selector = table_row_selector(model, row_id: row_id)
      have_selector(selector, options)
    end

    def have_table_col(text, options = {})
      model = options.delete(:model)
      row_id = options.delete(:row_id)
      col_name = options.delete(:col_name)
      selector = table_col_selector(model, row_id: row_id, col_name: col_name)
      opts = options.merge(text: text)
      have_selector(selector, opts)
    end

    def table_selector(model)
      model ||= current_table_model
      return 'table.index_table' if model.nil?

      "table.index_table#index_table_#{model.to_s.pluralize}"
    end

    def table_row_selector(model, row_id: nil)
      model ||= current_table_model
      raise ArgumentError, "model required when row_id is passed" if row_id && model.nil?

      selector = table_selector(model)

      row_selector = row_id ? "tr##{model.to_s.singularize}_#{row_id}" : 'tr'
      "#{selector} > tbody > #{row_selector}"
    end

    def table_col_selector(model, row_id: nil, col_name: nil)
      model ||= current_table_model
      col_name = col_name.to_s.gsub(' ', '_').downcase if col_name
      selector = table_row_selector(model, row_id: row_id)
      col_selector = col_name ? "td.col.col-#{col_name}" : 'td.col'
      "#{selector} > #{col_selector}"
    end

    def with_table_for(model)
      old = @_active_admin_rspec_table_model
      @_active_admin_rspec_table_model = model
      yield
    ensure
      @_active_admin_rspec_table_model = old
    end

    def current_table_model
      @_active_admin_rspec_table_model
    end

    # extend RSpec::Matchers::DSL
    # matcher :have_action_item do |expected|
    # end
  end
end
