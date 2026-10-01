# frozen_string_literal: true

# ActiveAdmin and Arbre derive these DOM names from the model and the
# registered resource name. Asserting them against a real rendered page is the
# only way to catch a derivation that merely looks plausible: the previous one
# produced `billing::employee`, which is not a selector at all.
RSpec.describe 'DOM names of a namespaced resource', type: :feature, js: true do
  let!(:record) { Billing::Employee.create!(full_name: 'John Doe', salary: 100) }

  it 'finds the attributes table from the model class and from its name' do
    visit admin_business_employee_path(record.id)

    expect(page).to have_attributes_table(model: Billing::Employee)
    expect(page).to have_attributes_table(model: 'Billing::Employee')
  end

  it 'finds the index table by the name the resource was registered under' do
    visit admin_business_employees_path

    expect(page).to have_table(resource_name: 'Business Employee')
  end
end
