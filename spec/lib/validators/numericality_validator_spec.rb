require "spec_helper"

describe ValidatedFields::Validators::NumericalityValidator do
  it "should add min, max and data-numericality-error-msg attrs" do
    input = @builder.text_field(:age, :validate => true)

    input.should match(/min="1"/)
    input.should match(/max="9"/)
    input.should match(/data-error-numericality="Wrong number format"/)
  end
end
