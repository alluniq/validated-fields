module ValidatedFields
  class JavascriptGenerator < Rails::Generators::Base
    desc "This generator copies the validated-fields.js file to the public/javascripts directory in your application."
    
    source_root File.expand_path("../../javascripts", __FILE__)

    # all public methods in here will be run in order
    def copy_javascript_file
      copy_file('validated-fields.js', 'public/javascripts/validated-fields.js')
    end
  end
end