# frozen_string_literal: true

RSpec.describe 'Business Employees show', js: true do
  subject do
    visit admin_business_employee_path(record.id)
  end

  let!(:record) { Billing::Employee.create!(full_name: 'John Doe', salary: 100) }
  before do
    Billing::Duty.create!(
        [
            { name: 'Normal work', duty_type: 'common', employee_id: record.id },
            { name: 'Extra work', duty_type: 'extra', employee_id: record.id }
        ]
    )
  end

  it 'have correct show page' do
    subject

    expect(page).to have_title(record.full_name)
    expect(page).to have_page_title(record.full_name)

    expect(page).to have_action_item('Edit Business Employee')
    expect(page).to have_action_item('Delete Business Employee')

    expect(page).to have_attributes_table
    expect(page).to have_attributes_table(model: Billing::Employee)
    expect(page).to have_attributes_table(model: Billing::Employee, id: record.id)

    within_attributes_table_for(Billing::Employee, record.id) do
      expect(page).to have_attribute_row('Full name')
      expect(page).to have_attribute_row('Full name', text: record.full_name)
      expect(page).to have_attribute_row('Salary', exact_text: '$100.00')
    end

    switch_tab('Duties')

    within_table_for(Billing::Duty) do
      expect(page).to have_table_row(count: 2)
      expect(page).to have_table_row(id: record.duties.first.id)
      expect(page).to have_table_row(id: record.duties.second.id)
    end
  end

  it 'clicks edit link' do
    subject

    click_action_item('Edit Business Employee')

    expect(page).to have_current_path edit_admin_business_employee_path(record.id)
  end

  it 'clicks delete link' do
    subject

    accept_confirm do
      click_action_item('Delete Business Employee')
    end

    expect(page).to have_current_path admin_business_employees_path
    expect(page).to have_flash_message('Employee was successfully destroyed.', type: :notice, exact: true)
  end
end
