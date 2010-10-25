module ValidatedFields
  module Validators
    #
    # Sets options for ActiveModel::Validations::FormatValidator
    #
    module FormatValidator

      def self.prepare_options(validator, options)
        voptions = validator.options
        # TODO: tidy up regexes for javascript compatibility
        options[:pattern] = voptions[:with].inspect

        options["data-allow-blank"]  = true if voptions[:allow_nil].present?   && voptions[:allow_nil]   == true
        options["data-allow-blank"]  = true if voptions[:allow_blank].present? && voptions[:allow_blank] == true

        options["data-error-format"] = validator.options[:message] || 'Invalid format'
        options
      end
    end

  end
end
