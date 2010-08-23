module ValidatedFields
  module Validators
    #
    # Sets options for ActiveModel::Validations::PresenceValidator
    #
    module PresenceValidator
      def self.prepare_options(validator, options)
        options[:required] = "required"
        options["data-required-error-msg"] = validator.options[:message] if validator.options[:message].present?
        options
      end
    end
  end
end