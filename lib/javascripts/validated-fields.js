/**
 * ValidatedFields
 * -------------------
 * 
 * 
 */
function ValidatedFields(errorCallback, successCallback) {
        
    this.errorCallback   = errorCallback;
    this.successCallback = successCallback;
    
    /**
     * Event handler called when a form field loses focus (onblur).
     */
    this.validate = function(event) {
        var target = event.currentTarget;            // form field
        var errors = this.getErrorMessages(target);  // error messages in data-error attrs
        var valid  = true;
        
        var validators = $(target).attr('data-validates');
        if (!validators) {
            return;
        }
        
        validators = validators.split(' ');
        for (var i = 0; i < validators.length; i++) {
            // generate validator method name
            var validator = 'validate' + validators[i].slice(0, 1).toUpperCase() + validators[i].slice(1);
            
            valid = eval('this.' + validator + '($(target), errors);');
        }
        
        if (valid) {
            this.successCallback($(target));
        }
    };
    
    /**
     * Finds all attributes of element that begin with 'data-error-'
     * and extracts them to an array.
     */
    this.getErrorMessages = function(element) {
        var errors = new Array();
        
        for (var i = 0; i < element.attributes.length; i++) {
            var attr  = element.attributes[i];
            var match = attr.nodeName.match(/^data-error-(.*)$/);
            
            if (match) {
                errors[match[1]] = attr.nodeValue;
            }
        }
        
        return errors;
    };
    
    this.validatePresence = function(element, errors) {
        var value = jQuery.trim(element.attr('value'));
        if (value == "") {
            this.errorCallback(element, errors['presence']);
            return false;
        }
        return true;
    };
    
    this.validateFormat = function(element, errors) {
        var value   = jQuery.trim(element.attr('value'));
        var pattern = element.attr('pattern');
        
        // TODO
        return true;
    };
    
    this.validateLength = function(element, errors) {
        var value = jQuery.trim(element.attr('value'));
        var min   = parseInt(element.attr('min')); // the browser will take care of maxlength
        
        if (value.length < min) {
            this.errorCallback(element, errors['length']);
            return false;
        }
        return true;
    };
    
    // --------------------------------------------------------
    
    // set up events for all elements with the 'validated' class
    $('form .validated').blur(jQuery.proxy(this, "validate"));
}
