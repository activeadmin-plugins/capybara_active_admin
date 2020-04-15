# frozen_string_literal: true

RSpec.describe 'Users new', js: true do
  subject do
    visit new_admin_user_path
  end

  it 'checks new user page' do
    subject

    expect(page).to have_title('New User')
    expect(page).to have_page_title('New User')

    within_form_for(User) do
      expect(page).to have_field('Full name')
      expect(page).to_not have_field('Test')
      fill_in 'Full name', with: 'John Doe'
      click_submit 'Create User'
    end

    # TODO: nested has_many
    # TODO: nested has_one

    expect(page).to have_flash_message('User was successfully created.', type: :notice)
    user = User.last!
    expect(page).to have_current_path admin_user_path(user.id)

    expect(User.count).to eq(1)
    expect(user).to have_attributes(
                        full_name: 'John Doe'
                    )
  end
end
