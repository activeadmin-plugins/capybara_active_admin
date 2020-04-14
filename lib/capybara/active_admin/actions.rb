# frozen_string_literal: true

require 'capybara/active_admin/actions/layout'
require 'capybara/active_admin/actions/table'
require 'capybara/active_admin/actions/attributes_table'
require 'capybara/active_admin/actions/form'

module Capybara
  module ActiveAdmin
    module Actions
      # Actions are interactions with page that change something.
      # Click, scroll, fill, clear, switch - all these are interactions.

      include Actions::Layout
      include Actions::Table
      include Actions::AttributesTable
      include Actions::Form
    end
  end
end
