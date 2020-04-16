# frozen_string_literal: true

require 'capybara/active_admin/finders/layout'
require 'capybara/active_admin/finders/table'
require 'capybara/active_admin/finders/attributes_table'
require 'capybara/active_admin/finders/form'

module Capybara
  module ActiveAdmin
    # Finders are methods that find DOM element(s) or change current scope to node element.
    #
    # Find element(s) method names should start with *find_*.
    #
    # Change current scope method names should start with *within_*.
    module Finders
      include Finders::Layout
      include Finders::Table
      include Finders::AttributesTable
      include Finders::Form
    end
  end
end
