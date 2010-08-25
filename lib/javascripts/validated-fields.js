/**
 *
 */
var ValidatedFields = {
    
    errorCallback:   null,
    successCallback: null,
    
    initialize: function(errorCallback, successCallback) {
        $('form .validated').blur(this.validate);
        
        this.errorCallback   = errorCallback;
        this.successCallback = successCallback;
    },
    
    validate: function() {
        var errors = ValidatedFields.getErrorMessages(this);
        var valid  = true;
        
        var validators = $(this).attr('data-validates');
        if (!validators) {
            return;
        }
        
        validators = validators.split(' ');
        for (var i = 0; i < validators.length; i++) {
            // generate validator method name
            var validator = 'validate' + validators[i].slice(0, 1).toUpperCase() + validators[i].slice(1);
            
            valid = eval('ValidatedFields.' + validator + '($(this), errors);');
        }
        
        if (valid) {
            ValidatedFields.successCallback($(this));
        }
    },
    
    getErrorMessages: function(element) {
        var errors = new Array();
        
        for (var i = 0; i < element.attributes.length; i++) {
            var attr  = element.attributes[i];
            var match = attr.nodeName.match(/^data-error-(.*)$/);
            
            if (match) {
                errors[match[1]] = attr.nodeValue;
            }
        }
        
        return errors;
    },
    
    validatePresence: function(element, errors) {
        var value = jQuery.trim(element.attr('value'));
        if (value == "") {
            ValidatedFields.errorCallback(element, errors['presence']);
            return false;
        }
        return true;
    },
    
    validateFormat: function(element, errors) {
        var value   = jQuery.trim(element.attr('value'));
        var pattern = element.attr('pattern');
        
        // TODO
        return true;
    },
    
    validateLength: function(element, errors) {
        var value = jQuery.trim(element.attr('value'));
        var min   = parseInt(element.attr('min')); // the browser will take care of maxlength
        
        if (value.length < min) {
            ValidatedFields.errorCallback(element, errors['length']);
            return false;
        }
        return true;
    }
}
