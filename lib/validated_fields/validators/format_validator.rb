module ValidatedFields
  module Validators
    #
    # Sets options for ActiveModel::Validations::FormatValidator
    #
    module FormatValidator

      def self.prepare_options(validator, options)
        # TODO: tidy up regexes for javascript compatibility
        options[:pattern] = validator.options[:with].inspect

        options["data-allow-blank"] = true if validator.options[:allow_nil].present?   && validator.options[:allow_nil]   == true
        options["data-allow-blank"] = true if validator.options[:allow_blank].present? && validator.options[:allow_blank] == true

        options["data-format-error-msg"] = validator.options[:message] if validator.options[:message].present?
        options
      end
    end
    
  end
end