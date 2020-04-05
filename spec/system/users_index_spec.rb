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

    with_table_for('users') do
      expect(page).to have_table_row(count: 2)
      expect(page).to have_table_col('John Doe')
      expect(page).to have_table_col('John Doe', row_id: john.id)
      expect(page).to have_table_col('John Doe', row_id: john.id, col_name: 'Full Name')

      expect(page).to_not have_table_col('John Doe', row_id: john.id, col_name: 'Id')
      expect(page).to_not have_table_col('John Doe', row_id: jane.id)
      expect(page).to_not have_table_col('John Doe', row_id: jane.id, col_name: 'Full Name')
    end
    # take_screenshot
  end

  # todo filters expect to have
  # todo filters fill and click
  # todo breadcrumbs expect to have
  # todo breadcrumbs click
  # todo menu items expect to have
  # todo menu items click
end
