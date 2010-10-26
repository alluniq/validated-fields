require "action_view"
require "action_controller"

require "rspec"
require "validated_fields"
require "fixtures"

RSpec.configure do |config|
  config.before :each do
    @user       = User.new
    @controller = UsersController.new
    @builder    = ValidatedFields::FormBuilder.new(:user, @user, @controller, {:validate => true}, nil)
  end
end

module SpecHelper
  include ActionPack
  include ActionView::Context if defined?(ActionView::Context)
  include ActionController::RecordIdentifier
  include ActionView::Helpers::FormHelper
  include ActionView::Helpers::FormTagHelper
  include ActionView::Helpers::FormOptionsHelper
  include ActionView::Helpers::UrlHelper
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::ActiveRecordHelper if defined?(ActionView::Helpers::ActiveRecordHelper)
  include ActionView::Helpers::ActiveModelHelper if defined?(ActionView::Helpers::ActiveModelHelper)
  include ActionView::Helpers::DateHelper
  include ActionView::Helpers::CaptureHelper
  include ActionView::Helpers::AssetTagHelper

  def self.included(base)
    base.class_eval do
      def protect_against_forgery?
        false
      end
    end
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
