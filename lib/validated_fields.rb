require "validated_fields/form_builder"

module ValidatedFields
  module Validators
    autoload :PresenceValidator,     "validated_fields/validators/presence_validator"
    autoload :FormatValidator,       "validated_fields/validators/format_validator"
    autoload :LengthValidator,       "validated_fields/validators/length_validator"
    autoload :NumericalityValidator, "validated_fields/validators/numericality_validator"
  end

  def self.included(base)
    base.class_eval do
      include ValidatedFields::Validators::PresenceValidator
      include ValidatedFields::Validators::FormatValidator
      include ValidatedFields::Validators::LengthValidator
      include ValidatedFields::Validators::NumericalityValidator
    end
  end
end

ActiveSupport.on_load(:action_view) do
  include ValidatedFields
  ActionView::Base.default_form_builder = ValidatedFields::FormBuilder
end
