# frozen_string_literal: true

module Capybara
  module ActiveAdmin
    module TestHelpers
      include Selectors
      include Finders
      include Matchers
      include Actions
    end
  end
end
