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

      # ActiveAdmin derives the CSS class of a row or column from the
      # label with `parameterize(separator: '_')` --
      # `AttributesTable#row` and `TableFor::Column#html_class`. Mirror
      # that call rather than approximating it, so every label lands on
      # the class ActiveAdmin actually rendered.
      def css_class_for_label(label)
        label.to_s.parameterize(separator: '_')
      end

      def options_with_text(text, options = {})
        key = options[:exact] ? :exact_text : :text

        options.except(:exact).merge(key => text)
      end

      module_function :parse_model_name, :css_class_for_label, :options_with_text
    end
  end
end
