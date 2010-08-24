module ValidatedFields
  module Validators
    #
    # Sets options for ActiveModel::Validations::NumericalityValidator
    #
    module NumericalityValidator

      def self.prepare_options(validator, options)
        voptions = validator.options
        
        # FIXME: will work properly only for integers
        options[:min] = voptions[:greater_than].to_i + 1 if voptions[:greater_than].present?
        options[:max] = voptions[:less_than].to_i    - 1 if voptions[:less_than].present?
        
        options[:min] = voptions[:greater_than_or_equal_to].to_i + 1 if voptions[:greater_than_or_equal_to].present?
        options[:max] = voptions[:less_than_or_equal_to].to_i    - 1 if voptions[:less_than_or_equal_to].present?
        
        options['data-numericality-error-msg'] = voptions[:message] if voptions[:message].present?
        options
      end
    end
    
  end
end