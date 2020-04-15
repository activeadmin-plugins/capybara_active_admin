---
home: true
actionText: Get Started →
actionLink: /guide/
footer: MIT Licensed | Copyright © 2020-present Denis Talakevich
---

<div style="text-align: center">
  <Bit/>
</div>

<div class="features">
  <div class="feature">
    <h2>Fast Test Writing</h2>
    <p>Allow to focus on what you want to test instead of how to do it.</p>
  </div>
  <div class="feature">
    <h2>Simplicity</h2>
    <p>Following Ruby an Capybara naming conventions allows easily to read and understand tests code.</p>
  </div>
  <div class="feature">
    <h2>Customizable</h2>
    <p>You can easy extend, customize, and mix parts of library to fit your needs.</p>
  </div>
</div>

### As Easy as 1, 2, 3

```bash
# install
gem install capybara_active_admin
# OR echo "gem 'capybara_active_admin', group: :test, require: false" >> Gemfile
```
```ruby
# require in in rspec/rails_helper.rb
require 'capybara/active_admin/rspec'
```

::: warning COMPATIBILITY NOTE
requires Ruby >= 2.3.
:::
