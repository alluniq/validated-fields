require "spec_helper"

describe ValidatedFields::Validators::FormatValidator do

  before(:each) do
    @user       = User.new
    @controller = UsersController.new
    @builder    = ValidatedFields::FormBuilder.new(:user, @user, @controller, {}, nil)
  end

  it "should add 'pattern' and 'data-format-error-msg' to fields that require specific format" do
    input = @builder.text_field(:email, :validate => true)

    input.should match(/pattern="\/.+"/) # TODO: lame
    input.should match(/data-error-format="Email is required"/)
  end
end