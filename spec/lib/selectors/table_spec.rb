# frozen_string_literal: true

RSpec.describe Capybara::ActiveAdmin::Selectors::Table do
  subject(:helper) do
    Class.new { include Capybara::ActiveAdmin::Selectors::Table }.new
  end

  describe '#table_header_selector' do
    it 'returns a generic header selector when no text given' do
      expect(helper.table_header_selector).to eq('thead > tr > th.col')
    end

    it 'builds selector from a simple label' do
      expect(helper.table_header_selector('Full Name')).to eq('thead > tr > th.col.col-full_name')
    end

    # ActiveAdmin builds the class with `parameterize(separator: '_')`
    # (TableFor::Column#html_class). These three labels are where a plain
    # space-for-underscore substitution drifts from it.
    it 'collapses a slash surrounded by spaces into a single separator' do
      expect(helper.table_header_selector('VAT / TAX Number'))
        .to eq('thead > tr > th.col.col-vat_tax_number')
    end

    it 'turns an apostrophe into a separator' do
      expect(helper.table_header_selector("Customer's Name"))
        .to eq('thead > tr > th.col.col-customer_s_name')
    end

    it 'trims a leading separator' do
      expect(helper.table_header_selector('# of DIDs')).to eq('thead > tr > th.col.col-of_dids')
    end

    it 'normalizes the column override the same way, not the visible text' do
      expect(helper.table_header_selector('Whatever', column: 'VAT / TAX Number'))
        .to eq('thead > tr > th.col.col-vat_tax_number')
    end

    it 'appends the sortable and sorted classes' do
      expect(helper.table_header_selector('Full Name', sortable: true, sort_direction: 'DESC'))
        .to eq('thead > tr > th.col.col-full_name.sortable.sorted-desc')
    end
  end

  describe '#table_selector' do
    it 'returns the generic selector when no resource name given' do
      expect(helper.table_selector).to eq('table.index_table')
    end

    it 'builds the id from a registered resource name' do
      expect(helper.table_selector('Business Employee')).to eq('table#index_table_business_employees')
    end

    # ActiveAdmin's id comes from `resource_name.plural`, which underscores the
    # namespace. `gsub(' ', '_')` left the `::` in place, and Nokogiri raises
    # on `table#index_table_billing::employees`.
    it 'underscores a namespaced name instead of leaving ::' do
      expect(helper.table_selector('Billing::Employee')).to eq('table#index_table_billing_employees')
    end

    it 'asks a model class for its own plural' do
      expect(helper.table_selector(Billing::Employee)).to eq('table#index_table_billing_employees')
    end
  end

  describe '#table_cell_selector' do
    it 'returns generic selector when column is nil' do
      expect(helper.table_cell_selector).to eq('td.col')
    end

    it 'converts spaces to underscores' do
      expect(helper.table_cell_selector('Full Name')).to eq('td.col.col-full_name')
    end

    it 'downcases the column name' do
      expect(helper.table_cell_selector('ID')).to eq('td.col.col-id')
    end

    it 'strips slashes from column name' do
      expect(helper.table_cell_selector('Country / Region')).to eq('td.col.col-country_region')
    end

    it 'strips other special characters from column name' do
      expect(helper.table_cell_selector('Price (USD)')).to eq('td.col.col-price_usd')
    end

    # ActiveAdmin builds the class with `parameterize(separator: '_')`
    # (TableFor::Column#html_class), so anything else is an approximation
    # that drifts on labels like these.
    it 'keeps a hyphen, the way parameterize does' do
      expect(helper.table_cell_selector('E-mail')).to eq('td.col.col-e-mail')
    end

    it 'turns an apostrophe into a separator rather than dropping it' do
      expect(helper.table_cell_selector("Customer's Name")).to eq('td.col.col-customer_s_name')
    end

    it 'trims a leading separator' do
      expect(helper.table_cell_selector('# of DIDs')).to eq('td.col.col-of_dids')
    end
  end
end
