require "spec_helper"

describe ValidatedFields::Validators::FormatValidator do

  it "should add 'pattern' and 'data-format-error-msg' to fields that require specific format" do
    input = @builder.text_field(:email, :validate => true)

    input.should match(/pattern="\/.+"/) # TODO: lame
    input.should match(/data-error-format="Email is required"/)
  end

  it "should add default error message if :message is not set" do
    input = @builder.text_field(:zipcode, :validate => true)
    input.should match(/data-error-format="Invalid format"/)
  end
end