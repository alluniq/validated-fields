module ValidatedFields
  module Helpers
    
    def check_box(object_name, method, options = {}, checked_value = "1", unchecked_value = "0")
      options = setup_validation_options(object_name, method, options)
      super(object_name, method, options, checked_value, unchecked_value)
    end
    
    def password_field(object_name, method, options = {})
      options = setup_validation_options(object_name, method, options)
      super(object_name, method, options)
    end
    
    def text_area(object_name, method, options = {})
      options = setup_validation_options(object_name, method, options)
      super(object_name, method, options)
    end
    
    def text_field(object_name, method, options = {})
      options = setup_validation_options(object_name, method, options)
      super(object_name, method, options)
    end
    
    protected
      # Override this method if you want to use some non-standard validators. See README for examples
      def setup_validation_options(object_name, attribute, options)
        return options if options[:validate].present? && options[:validate] == false
        
        options = require_field(object_name, attribute, options) if has_validator?(object_name, attribute, ActiveModel::Validations::PresenceValidator)
        options = check_format(object_name, attribute, options)  if has_validator?(object_name, attribute, ActiveModel::Validations::FormatValidator)
        options = check_length(object_name, attribute, options)  if has_validator?(object_name, attribute, ActiveModel::Validations::LengthValidator)
        
        options[:class] = options[:class].present? ? options[:class] + " validated" : "validated"
        
        options
      end
      
      def has_validator?(object_name, attribute, validator)
        validators_for(object_name, attribute).map(&:class).include?(validator)
      end
      
      # Retrieves given validator object
      def find_validator(object_name, attribute, validator_class)
        validators_for(object_name, attribute).find {|v| v.class == validator_class}
      end
      
      # Returns the list of all validators assigned to attribute
      def validators_for(object_name, attribute)
        object_name.to_s.classify.constantize.validators_on(attribute)
      end
      
      # -----------------------------------------------------------------------
      
      # Sets options for ActiveModel::Validations::PresenceValidator
      def require_field(object_name, attribute, options)
        validator = find_validator(object_name, attribute, ActiveModel::Validations::PresenceValidator)
        
        options[:required] = "required"
        options["data-required-error-msg"] = validator.options[:message] if validator.options[:message].present?
        options
      end
      
      # Sets options for ActiveModel::Validations::FormatValidator
      def check_format(object_name, attribute, options)
        validator = find_validator(object_name, attribute, ActiveModel::Validations::FormatValidator)
        
        # TODO: tidy up regexes for javascript compatibility
        options[:pattern] = validator.options[:with].inspect
        
        options["data-allow-blank"] = true if validator.options[:allow_nil].present?   && validator.options[:allow_nil]   == true
        options["data-allow-blank"] = true if validator.options[:allow_blank].present? && validator.options[:allow_blank] == true
        
        options["data-format-error-msg"] = validator.options[:message] if validator.options[:message].present?
        options
      end
      
      # Sets options for ActiveModel::Validations::LengthValidator
      def check_length(object_name, attribute, options)
        validator = find_validator(object_name, attribute, ActiveModel::Validations::LengthValidator)
        
        options[:min] = validator.options[:minimum]      if validator.options[:minimum].present?
        options[:min] = validator.options[:in].first     if validator.options[:in].present?
        options[:min] = validator.options[:within].first if validator.options[:within].present?
        
        options[:maxlength] = options[:max] = validator.options[:maximum]     if validator.options[:maximum].present?
        options[:maxlength] = options[:max] = validator.options[:in].last     if validator.options[:in].present?
        options[:maxlength] = options[:max] = validator.options[:within].last if validator.options[:within].present?
        
        options['data-length'] = validator.options[:is] if validator.options[:is].present?
        
        # messages
        options["data-length-error-msg"]       = validator.options[:message]      if validator.options[:message].present?
        options["data-wrong-length-error-msg"] = validator.options[:wrong_length] if validator.options[:wrong_length].present?
        options["data-too-long-error-msg"]     = validator.options[:too_long]     if validator.options[:too_long].present?
        options["data-too-short-error-msg"]    = validator.options[:too_short]    if validator.options[:too_short].present?
        
        options["data-allow-blank"] = true if validator.options[:allow_nil].present?   && validator.options[:allow_nil]   == true
        options["data-allow-blank"] = true if validator.options[:allow_blank].present? && validator.options[:allow_blank] == true
        
        options
      end
  end
end
