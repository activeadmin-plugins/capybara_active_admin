# frozen_string_literal: true

RSpec.describe 'Users index', js: true do
  subject do
    visit admin_users_path
  end

  it 'checks elements on empty users page' do
    subject

    expect(page).to have_text('There are no Users yet.')
    expect(page).to have_action_item('New User')
    expect(page).to_not have_action_item('Edit User')
  end

  it 'clicks on New User' do
    subject

    click_action_item('New User')
    expect(page).to have_current_path(new_admin_user_path)
  end

  it 'finds data in table' do
    john = User.create!(full_name: 'John Doe')
    jane = User.create!(full_name: 'Jane Air')
    subject

    within_table_for('users') do
      expect(page).to have_table_row(count: 2)
      expect(page).to have_table_cell(count: 10) # 2x id, full_name, created_at, updated_at, actions

      expect(page).to have_table_cell(text: 'John Doe')
      expect(page).to have_table_cell(text: 'John Doe', column: 'Full Name')
      expect(page).to_not have_table_cell(text: 'John Doe', column: 'Id')

      within_table_row(id: john.id) do
        expect(page).to have_table_cell(count: 5) # id, full_name, created_at, updated_at, actions
        expect(page).to have_table_cell(text: 'John Doe')
        expect(page).to have_table_cell(text: 'John Doe', column: 'Full Name')
        expect(page).to_not have_table_cell(text: 'John Doe', column: 'Id')
      end

      within_table_row(id: jane.id) do
        expect(page).to have_table_cell(count: 5) # id, full_name, created_at, updated_at, actions
        expect(page).to have_table_cell(text: jane.id, column: 'Id')
        expect(page).to have_table_cell(text: 'Jane Air', column: 'Full Name')
        expect(page).to_not have_table_cell(text: 'John Doe')
        expect(page).to_not have_table_cell(text: 'John Doe', column: 'Full Name')
      end
    end
    # take_screenshot
  end

  # TODO: filters expect to have
  # todo filters fill and click
  # todo breadcrumbs expect to have
  # todo breadcrumbs click
  # todo menu items expect to have
  # todo menu items click
end
