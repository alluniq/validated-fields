module ValidatedFields
  module Validators
    #
    # Sets options for ActiveModel::Validations::LengthValidator
    #
    # Should be used for strings only. In order to validata numbers,
    # use NumericalityValidator.
    #
    module LengthValidator
      def self.prepare_options(validator, options)
        voptions = validator.options
        
        options[:min] = voptions[:minimum]      if voptions[:minimum].present?
        options[:min] = voptions[:in].first     if voptions[:in].present?
        options[:min] = voptions[:within].first if voptions[:within].present?
        
        options[:maxlength] = voptions[:maximum]     if voptions[:maximum].present?
        options[:maxlength] = voptions[:in].last     if voptions[:in].present?
        options[:maxlength] = voptions[:within].last if voptions[:within].present?
        
        options['data-length'] = validator.options[:is] if validator.options[:is].present?
        
        # messages
        options["data-length-error-msg"]       = voptions[:message]      if voptions[:message].present?
        options["data-wrong-length-error-msg"] = voptions[:wrong_length] if voptions[:wrong_length].present?
        options["data-too-long-error-msg"]     = voptions[:too_long]     if voptions[:too_long].present?
        options["data-too-short-error-msg"]    = voptions[:too_short]    if voptions[:too_short].present?
        
        options["data-allow-blank"] = true if voptions[:allow_nil].present?   && voptions[:allow_nil]   == true
        options["data-allow-blank"] = true if voptions[:allow_blank].present? && voptions[:allow_blank] == true
        
        options
      end
    end
    
  end
end