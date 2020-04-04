# frozen_string_literal: true

RSpec.describe 'Users new', js: true do
  subject do
    visit new_admin_user_path
  end

  it 'checks new user page' do
    subject

    expect(page).to have_title('New User')
    expect(page).to have_page_title('New User')

    fill_in 'Full name', with: 'John Doe'
    click_button 'Create User'
    expect(page).to have_flash_message('User was successfully created.', type: :notice)
    user = User.last!
    expect(page).to have_current_path admin_user_path(user.id)

    expect(User.count).to eq(1)
    expect(user).to have_attributes(
                        full_name: 'John Doe'
                    )
  end
end
