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
        css_class = label.to_s.parameterize(separator: '_')
        return css_class if css_class.present?

        # `parameterize` transliterates to Latin and drops the rest, so any
        # label without Latin-transliterable characters -- 'Имя', '名前', '№',
        # or a blank string -- comes back empty. ActiveAdmin makes the same
        # call, so it renders `class="row row-"` for all of them, and a
        # `.row-` selector would match every one at once: the matcher would
        # pass against the wrong row instead of failing. Refuse to build it.
        raise ArgumentError,
              "cannot derive a CSS class from #{label.inspect}: " \
              'ActiveAdmin parameterizes it to an empty string, so every such ' \
              'row or column shares one class and cannot be told apart. ' \
              'Match on text, or pass the attribute name instead of the label.'
      end

      def options_with_text(text, options = {})
        key = options[:exact] ? :exact_text : :text

        options.except(:exact).merge(key => text)
      end

      module_function :parse_model_name, :css_class_for_label, :options_with_text
    end
  end
end
