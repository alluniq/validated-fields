require "action_view"
require "action_controller"

require "rspec"
require "validated_fields"
require "fixtures"

RSpec.configure do |config|
  config.before :each do
    @user       = User.new
    @controller = UsersController.new
    @builder    = ValidatedFields::FormBuilder.new(:user, @user, @controller, {}, nil)
  end
end

module ActionView
  module Helpers
    module CaptureHelper
      def with_output_buffer(buf = nil) #:nodoc:
        self.output_buffer, old_buffer = buf, output_buffer
        yield
        output_buffer
      ensure
        self.output_buffer = old_buffer
      end
    end
  end
end
