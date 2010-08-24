
module ValidatedFields  
  module Helpers
    def self.included(base)
      base.class_eval do
        include ValidatedFields::Validators::PresenceValidator
        include ValidatedFields::Validators::FormatValidator
        include ValidatedFields::Validators::LengthValidator
        include ValidatedFields::Validators::NumericalityValidator
      end
    end
    
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
        if options[:validate].nil? || options[:validate] != true
          options.delete(:validate) unless options[:validate].nil?
          return options
        end
        
        validations = 0
        
        validators = validators_for(object_name, attribute)
        validators.each do |validator|
          if validator.options[:if].present?
            object = options[:object]
            
            next if validator.options[:if].is_a?(Proc)   && validator.options[:if].call(object) == false
            next if validator.options[:if].is_a?(Symbol) && object.send(validator.options[:if]) == false
          end
          
          validator_name = validator.class.to_s.split("::").last
          
          if ValidatedFields::Validators.const_defined?(validator_name)
            options = eval("ValidatedFields::Validators::#{validator_name}").prepare_options(validator, options)
          end
          validations += 1
        end
        
        options[:class] = options[:class].present? ? options[:class] + " validated" : "validated" if validations > 0
        options.delete(:validate) unless options[:validate].nil?
        
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
  end
end
