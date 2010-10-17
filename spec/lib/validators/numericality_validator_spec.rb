require "spec_helper"

describe ValidatedFields::Validators::NumericalityValidator do

  before(:each) do
    @user       = User.new
    @controller = UsersController.new
    @builder    = ValidatedFields::FormBuilder.new(:user, @user, @controller, {}, nil)
  end

  it "should add min, max and data-numericality-error-msg attrs" do
    input = @builder.text_field(:age, :validate => true)

    input.should match(/min="1"/)
    input.should match(/max="9"/)
    input.should match(/data-error-numericality="Wrong number format"/)
  end
end
