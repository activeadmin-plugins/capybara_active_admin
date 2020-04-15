# Introduction

<Bit/>

`Capybara::ActiveAdmin` created to write tests as fast as `ActiveAdmin` resource which they are test.

## Getting Started

### Installation
 
```ruby
# Gemfile

gem 'capybara_active_admin', group: :test, require: false
```

```ruby
# spec/rails_helper.rb

# after require 'rspec' or 'rspec/rails'
require 'capybara/active_admin/rspec'
```

### Usage

For example we have such database table
```ruby
create_table :users do |t|
  t.string :full_name
  t.timestamps
end
```
And such `ActiveRecord` model
```ruby
class User < ActiveRecord::Base
  validates :full_name, presence: true
end
```
And there is our `ActiveAdmin` resource
```ruby
ActiveAdmin.register User do
  permit_params :full_name
end
```

Our test can look like below
```ruby
# spec/system/users_spec.rb

RSpec.describe 'Users' do

  describe 'index page' do
    subject do
      visit admin_users_path
    end

    it 'have no table' do
      subject

      expect(page).to have_text('There are no Users yet.')
      expect(page).to have_action_item('New User')
      expect(page).to_not have_action_item('Edit User')
      expect(page).to_not have_table
    end

    context 'with users' do
      let!(:users) do
        [
          User.create!(full_name: 'John Doe'),
          User.create!(full_name: 'Jane Air')
        ]
      end

      it 'have correct table rows' do
        subject

        # you can check that table is visible on page
        expect(page).to have_table

        # checkout data within table,
        # same as `within(table_selector) do`
        within_table_for do
          # check how many rows in table (tr)
          expect(page).to have_table_row(count: 2)
          # or cells (td)
          expect(page).to have_table_cell(count: 10)
          # or check cell of specific column contain specific value,
          # accepts same options as `have_selector`, such as :text, :exact_text, :count, etc.
          expect(page).to have_table_cell(text: 'John Doe', column: 'Full Name')

          # we can check data inside specific row by record id,
          # or we can find it by index in table `within_table_row(index: 0) do`.
          within_table_row(id: users.first.id) do
            # default columns for users table are id, full_name, created_at, updated_at, actions.
            expect(page).to have_table_cell(count: 5)
            expect(page).to have_table_cell(text: 'John Doe')
            # or you can write
            expect(page).to have_table_cell(text: 'John Doe', column: 'Full Name')
            # negate matcher
            expect(page).to_not have_table_cell(text: 'John Doe', column: 'Id')
          end

          within_table_row(id: users.second.id) do
            expect(page).to have_table_cell(text: users.second.id, column: 'Id')
            expect(page).to have_table_cell(text: 'Jane Air', column: 'Full Name')
            expect(page).to_not have_table_cell(text: 'John Doe')
          end
        end
      end
    end
  end
end
```
