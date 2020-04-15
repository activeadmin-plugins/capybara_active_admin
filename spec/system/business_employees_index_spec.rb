# frozen_string_literal: true

RSpec.describe 'Business Employees index', js: true do
  subject do
    visit admin_business_employees_path
  end

  it 'checks elements on empty users page' do
    subject

    expect(page).to have_text('There are no Business Employees yet.')
    expect(page).to have_action_item('New Business Employee')
    expect(page).to_not have_action_item('Edit Business Employee')
  end

  it 'clicks on New resource_name: ' do
    subject

    click_action_item('New Business Employee')
    expect(page).to have_current_path(new_admin_business_employee_path)
  end

  it 'finds data in table' do
    john = Billing::Employee.create!(full_name: 'John Doe', salary: 100)
    jane = Billing::Employee.create!(full_name: 'Jane Air', salary: 101)
    john.update! duties_attributes: [name: 'hard work', duty_type: 'common']
    jane.update! duties_attributes: [name: 'home work', duty_type: 'extra']
    subject

    expect(page).to have_table
    expect(page).to have_table(resource_name: 'Business Employees')
    within_table_for(Billing::Employee) do
      expect(page).to have_table_row(count: 2)
      # 2x id, full_name, salary, common_duties, extra_duties, created_at, updated_at, actions
      expect(page).to have_table_cell(count: 16)

      expect(page).to have_table_cell(text: 'John Doe')
      expect(page).to have_table_cell(text: 'John Doe', column: 'Full Name')
      expect(page).to_not have_table_cell(text: 'John Doe', column: 'Id')

      within_table_row(id: john.id) do
        expect(page).to have_table_cell(count: 8)
        expect(page).to have_table_cell(text: 'John Doe')
        expect(page).to have_table_cell(text: 'John Doe', column: 'Full Name')
        expect(page).to have_table_cell(text: '$100.00', column: 'Salary')
        expect(page).to have_table_cell(exact_text: 'hard work', column: 'Common Duties')
        expect(page).to have_table_cell(exact_text: '', column: 'Extra Duties')
        expect(page).to_not have_table_cell(text: 'John Doe', column: 'Id')
      end

      within_table_row(id: jane.id) do
        expect(page).to have_table_cell(count: 8)
        expect(page).to have_table_cell(text: jane.id, column: 'Id')
        expect(page).to have_table_cell(text: 'Jane Air', column: 'Full Name')
        expect(page).to have_table_cell(exact_text: '$101.00', column: 'Salary')
        expect(page).to have_table_cell(exact_text: '', column: 'Common Duties')
        expect(page).to have_table_cell(exact_text: 'home work', column: 'Extra Duties')
        expect(page).to_not have_table_cell(text: 'John Doe')
        expect(page).to_not have_table_cell(text: 'John Doe', column: 'Full Name')
      end
    end
    # take_screenshot
  end
end
