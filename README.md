# Capybara Active Admin

[![CI](https://github.com/activeadmin-plugins/capybara_active_admin/actions/workflows/ci.yml/badge.svg)](https://github.com/activeadmin-plugins/capybara_active_admin/actions/workflows/ci.yml)
[![Coverage](https://img.shields.io/endpoint?url=https://activeadmin-plugins.github.io/capybara_active_admin/badge.json)](https://activeadmin-plugins.github.io/capybara_active_admin/)
[![Gem Version](https://badge.fury.io/rb/capybara_active_admin.svg)](https://badge.fury.io/rb/capybara_active_admin)
[![Downloads](https://img.shields.io/gem/dt/capybara_active_admin)](https://rubygems.org/gems/capybara_active_admin)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)

Capybara DSL for fast and easy testing Active Admin applications.

Check out our docs at [activeadmin-plugins.github.io/capybara_active_admin](https://activeadmin-plugins.github.io/capybara_active_admin)

## Installation

Add this line to your application's Gemfile:

```ruby
group :test do
  gem 'capybara_active_admin'
end
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install capybara_active_admin

**Note: `capybara_active_admin` should be required after `capybara`.**

## Usage

`rails_helper.rb`
```ruby
require 'capybara/active_admin/rspec'
```

`spec/system/users_spec.rb`
```ruby
RSpec.describe 'Users', js: true do
  subject do
    visit admin_users_path
  end

  let!(:john) { User.create!(full_name: 'John Doe') }
  let!(:jane) { User.create!(full_name: 'Jane Air') }

  it 'have john and jane in users table' do
    subject

    expect(page).to have_action_item('New User')
    expect(page).to_not have_action_item('Edit User')

    within_table_for('users') do
      expect(page).to have_table_row(count: 2)
      expect(page).to have_table_cell(text: 'John Doe')

      within_table_row(id: john.id) do
        expect(page).to have_table_cell(text: 'John Doe')
        expect(page).to have_table_cell(text: 'John Doe', column: 'Full Name')
        expect(page).to_not have_table_cell(text: 'John Doe', column: 'Id')
      end

      within_table_row(id: jane.id) do
        expect(page).to_not have_table_cell(text: 'John Doe')
        expect(page).to_not have_table_cell(text: 'John Doe', column: 'Full Name')
      end
    end
  end

  it 'creates user' do
    subject

    click_action_item('New User')
    expect(page).to have_current_path(new_admin_user_path)

    within_form_for(User) do
      fill_in 'Full name', with: 'Johny Cage'
      click_submit 'Create User'
    end

    expect(page).to have_flash_message('User was successfully created.', type: :notice)
    user = User.last!
    expect(page).to have_current_path admin_user_path(user.id)

    expect(User.count).to eq(1)
    expect(user).to have_attributes(full_name: 'Johny Cage')
  end
end
```

See `spec/support` for more user examples.
See `capybara/active_admin/test_helpers.rb` for available DSL methods.

## How labels become selectors

Most helpers take the label you see on the page and build a CSS selector from
it, because that is how ActiveAdmin names its own elements. Two derivations are
worth knowing, since a mismatch shows up as "element not found" with no hint of
why.

### Column and row labels

ActiveAdmin builds the class with `parameterize(separator: '_')` —
`AttributesTable#row` and `TableFor::Column#html_class` — and so does this gem:

| label | class ActiveAdmin renders |
| --- | --- |
| `'Full Name'` | `col-full_name` |
| `:full_name` | `col-full_name` |
| `'VAT / TAX Number'` | `col-vat_tax_number` |
| `'E-mail'` | `col-e-mail` |
| `"Customer's Name"` | `col-customer_s_name` |
| `'# of DIDs'` | `col-of_dids` |

So pass the label as it appears, and do **not** normalize it yourself first —
doing it twice strips the separator the first pass inserted.

Two cases have no class to match:

```ruby
# ActiveAdmin renders class="row" with no row-* at all when you give your own
row :salary, class: 'money'

# parameterize drops everything non-Latin, so AA renders a bare class="row row-"
# for every such label and they cannot be told apart. The gem raises rather
# than match the wrong one.
row 'Имя'
```

Match on text in both cases, or pass the attribute name rather than the label.

### Model and resource names

`have_attributes_table(model:)` and `within_form_for` follow the **model
class** — Arbre uses `model_name.singular`:

```ruby
have_attributes_table(model: Billing::Employee)     # div.attributes_table.billing_employee
have_attributes_table(model: 'Billing::Employee')   # same
```

`have_table(resource_name:)` and `within_table_for` follow the name the
resource was **registered** under, which `as:` detaches from the model:

```ruby
ActiveAdmin.register Billing::Employee, as: 'Business Employee'

within_table_for('Business Employee') { ... }   # table#index_table_business_employees
within_table_for(Billing::Employee)   { ... }   # table#index_table_billing_employees -- wrong
```

A renamed resource has to be addressed by its registered name; the class cannot
know it.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/activeadmin-plugins/capybara_active_admin. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/activeadmin-plugins/capybara_active_admin/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Capybara::ActiveAdmin project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/activeadmin-plugins/capybara_active_admin/blob/master/CODE_OF_CONDUCT.md).

## Notes

Project uses [Keep a Changelog](https://keepachangelog.com/en/1.0.0/) convention.
Project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).
