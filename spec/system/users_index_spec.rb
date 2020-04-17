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
    expect(page).to_not have_table
    expect(page).to_not have_table(resource_name: 'Users')
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

    expect(page).to have_table
    expect(page).to have_table(resource_name: 'Users')
    within_table_for(User) do
      expect(page).to have_table_row(count: 2)
      # 2x6 (selectable, id, full_name, created_at, updated_at, actions)
      expect(page).to have_table_cell(count: 12)

      expect(page).to have_table_cell(text: 'John Doe')
      expect(page).to have_table_cell(text: 'John Doe', column: 'Full Name')
      expect(page).to_not have_table_cell(text: 'John Doe', column: 'Id')

      within_table_row(id: john.id) do
        # selectable, id, full_name, created_at, updated_at, actions
        expect(page).to have_table_cell(count: 6)
        expect(page).to have_table_cell(text: 'John Doe')
        expect(page).to have_table_cell(text: 'John Doe', column: 'Full Name')
        expect(page).to_not have_table_cell(text: 'John Doe', column: 'Id')
      end

      within_table_row(id: jane.id) do
        expect(page).to have_table_cell(count: 6)
        expect(page).to have_table_cell(text: jane.id, column: 'Id')
        expect(page).to have_table_cell(text: 'Jane Air', column: 'Full Name')
        expect(page).to_not have_table_cell(text: 'John Doe')
        expect(page).to_not have_table_cell(text: 'John Doe', column: 'Full Name')
      end
    end
  end

  # TODO: filters expect to have
  # TODO: filters fill and click
  # TODO: breadcrumbs expect to have
  # TODO: breadcrumbs click
  # TODO: menu items expect to have
  # TODO: menu items click
end
