require "validated_fields/helpers"

module ValidatedFields
  module Validators
    autoload :PresenceValidator,     "validated_fields/validators/presence_validator"
    autoload :FormatValidator,       "validated_fields/validators/format_validator"
    autoload :LengthValidator,       "validated_fields/validators/length_validator"
    autoload :NumericalityValidator, "validated_fields/validators/numericality_validator"
  end
end

ActiveSupport.on_load(:action_view) do
  include ValidatedFields::Helpers
end
