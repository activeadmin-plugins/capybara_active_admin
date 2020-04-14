# frozen_string_literal: true

require 'singleton'
require 'capybara/active_admin/selectors/layout'
require 'capybara/active_admin/selectors/table'
require 'capybara/active_admin/selectors/attributes_table'
require 'capybara/active_admin/selectors/form'

module Capybara
  module ActiveAdmin
    module Selectors
      # Methods that return css/xpath selectors should be placed here.

      include Selectors::Layout
      include Selectors::Table
      include Selectors::AttributesTable
      include Selectors::Form
    end
  end
end
