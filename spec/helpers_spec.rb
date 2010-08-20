require "spec_helper"

describe ValidatedFields::Helpers do
 
  before(:each) do
    @user       = User.new
    @controller = UsersController.new
    @builder    = ActionView::Helpers::FormBuilder.new(:user, @user, @controller, {}, nil)
  end

  it "should add 'validated' class if there's no class in options" do
    @builder.text_field(:name).should match(/class="validated"/)
  end
  
  it "should add 'validated' class if the 'class' option already has a value assigned" do
    @builder.text_field(:name, :class => 'foobar').should match(/class="foobar validated"/)
  end

  it "should add 'required' and 'data-required-error-msg' to required text fields" do
    input = @builder.text_field(:name)
    input.should match(/required="required"/)
    input.should match(/data-required-error-msg="Name is required"/)
  end
  
  it "should add 'pattern' and 'data-format-error-msg' to fields that require specific format" do
    input = @builder.text_field(:email)
    
    input.should match(/pattern="\/.+"/) # TODO: lame
    input.should match(/data-format-error-msg="Email is required"/)
  end
end