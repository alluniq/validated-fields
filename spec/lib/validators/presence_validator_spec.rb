require "spec_helper"

describe ValidatedFields::Validators::PresenceValidator do
  it "should add 'required' and 'data-required-error-msg' to required text fields" do
    input = @builder.text_field(:name, :validate => true)

    input.should match(/required="required"/)
    input.should match(/data-error-presence="Name is required"/)
    input.should_not match(/validated="true"/)
  end
end