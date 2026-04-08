# frozen_string_literal: true

RSpec.describe Capybara::ActiveAdmin::Selectors::AttributesTable do
  subject(:helper) do
    Class.new { include Capybara::ActiveAdmin::Selectors::AttributesTable }.new
  end

  describe '#attributes_row_selector' do
    it 'returns a generic row selector when no label given' do
      expect(helper.attributes_row_selector).to eq('tr.row > td')
    end

    it 'builds selector from a simple label' do
      expect(helper.attributes_row_selector('Full name')).to eq('tr.row.row-full_name > td')
    end

    it 'replaces slash with underscore to match ActiveAdmin class generation' do
      expect(helper.attributes_row_selector('USA/UAH')).to eq('tr.row.row-usa_uah > td')
    end

    it 'replaces spaces and slashes with underscores' do
      expect(helper.attributes_row_selector('A/B C')).to eq('tr.row.row-a_b_c > td')
    end
  end
end
