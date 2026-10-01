# frozen_string_literal: true

RSpec.describe Capybara::ActiveAdmin::Selectors::AttributesTable do
  subject(:helper) do
    Class.new { include Capybara::ActiveAdmin::Selectors::AttributesTable }.new
  end

  describe '#attributes_table_selector' do
    it 'asks a model class for its DOM name' do
      expect(helper.attributes_table_selector(model: Billing::Employee))
        .to eq('div.attributes_table.billing_employee')
    end

    # Arbre uses `model_name.singular` — underscore, then '/' -> '_'. The
    # previous `gsub(' ', '_')` kept the '::' and Nokogiri raised on
    # `div.attributes_table.billing::employee`.
    it 'underscores a namespaced name given as a string' do
      expect(helper.attributes_table_selector(model: 'Billing::Employee'))
        .to eq('div.attributes_table.billing_employee')
    end
  end

  describe '#attributes_row_selector' do
    # ActiveAdmin derives the class with the same `parameterize` call, so a
    # label it cannot transliterate renders as a bare `row-` on every such
    # row. Building that selector would match them all and pass against the
    # wrong one, so it has to raise instead.
    it 'refuses a label that parameterizes to nothing' do
      expect { helper.attributes_row_selector('Имя') }
        .to raise_error(ArgumentError, /cannot derive a CSS class from "Имя"/)
    end

    it 'refuses a blank label' do
      expect { helper.attributes_row_selector('   ') }.to raise_error(ArgumentError)
    end

    it 'returns a generic row selector when no label given' do
      expect(helper.attributes_row_selector).to eq('tr.row > td')
    end

    it 'builds selector from a simple label' do
      expect(helper.attributes_row_selector('Full name')).to eq('tr.row.row-full_name > td')
    end

    it 'substitutes a slash with the separator' do
      expect(helper.attributes_row_selector('USA/UAH')).to eq('tr.row.row-usa_uah > td')
    end

    # ActiveAdmin builds the class with `parameterize(separator: '_')`
    # (AttributesTable#row), which collapses a run of separators into one.
    it 'collapses a slash surrounded by spaces into a single separator' do
      expect(helper.attributes_row_selector('VAT / TAX Number'))
        .to eq('tr.row.row-vat_tax_number > td')
    end

    it 'collapses repeated whitespace' do
      expect(helper.attributes_row_selector('DID  Number')).to eq('tr.row.row-did_number > td')
    end

    it 'drops a trailing separator' do
      expect(helper.attributes_row_selector('Notes:')).to eq('tr.row.row-notes > td')
    end

    it 'replaces spaces and slashes with underscores' do
      expect(helper.attributes_row_selector('A/B C')).to eq('tr.row.row-a_b_c > td')
    end
  end
end
