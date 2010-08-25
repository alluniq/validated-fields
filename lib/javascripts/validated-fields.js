/**
 *
 */
var ValidatedFields = {
    
    errorCallback: null,
    
    initialize: function(callback) {
        $('form .validated').blur(this.validate);
        
        this.errorCallback = callback;
    },
    
    validate: function() {
        if ($(this).attr('required')) {
            ValidatedFields.validatePresence($(this));
        }
        
        if ($(this).attr('pattern')) {
            ValidatedFields.validateFormat($(this));
        }
        
        if ($(this).attr('min') && $(this).attr('maxlength')) {
            ValidatedFields.validateLength($(this));
        }
    },
    
    validatePresence: function(element) {
        var value = jQuery.trim(element.attr('value'));
        
        if (value == "") {
            ValidatedFields.errorCallback(element, element.attr('data-required-error-msg'));
        }
    },
    
    validateFormat: function(element) {
        var value   = jQuery.trim(element.attr('value'));
        var pattern = element.attr('pattern');
        
        // TODO
    },
    
    validateLength: function(element) {
        var value = jQuery.trim(element.attr('value'));
        var min   = parseInt(element.attr('min')); // the browser will take care of maxlength
        
        // TODO
    }
}
