# frozen_string_literal: true

module Capybara
  module ActiveAdmin
    module Util
      # Common pure utility functions

      def parse_model_name(model_name, singular: true)
        return if model_name.nil?

        model_name = model_name.model_name.singular if model_name.is_a?(Class)
        model_name = model_name.to_s.gsub(' ', '_').downcase
        singular ? model_name.singularize : model_name.pluralize
      end

      def options_with_text(text, options = {})
        key = options[:exact] ? :exact_text : :text

        options.except(:exact).merge(key => text)
      end

      module_function :parse_model_name, :options_with_text
    end
  end
end
