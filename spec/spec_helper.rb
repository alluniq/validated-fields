require "rubygems"
require "bundler"
Bundler.setup

require "active_support"
require "action_pack"
require "active_model"

require "action_controller"
require "action_view"

#require "rspec"
require "validated_fields"
require "fixtures"

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
