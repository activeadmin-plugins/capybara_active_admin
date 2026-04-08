# frozen_string_literal: true

RSpec.describe Capybara::ActiveAdmin::Selectors::Table do
  subject(:helper) do
    Class.new { include Capybara::ActiveAdmin::Selectors::Table }.new
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
  end
end
