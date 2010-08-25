module ValidatedFields
  module Validators
    #
    # Sets options for ActiveModel::Validations::PresenceValidator
    #
    module PresenceValidator
      def self.prepare_options(validator, options)
        options[:required] = "required"
        options["data-error-presence"] = validator.options[:message] || "This field is required"
        options
      end
    end
  end
end