require "validated_fields/helpers"

ActiveSupport.on_load(:action_view) do
  include ValidatedFields::Helpers
end
