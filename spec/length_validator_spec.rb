require "spec_helper"

describe ValidatedFields::Validators::LengthValidator do
 
  before(:each) do
    @user       = User.new
    @controller = UsersController.new
    @builder    = ActionView::Helpers::FormBuilder.new(:user, @user, @controller, {}, nil)
  end
  
  it "should add 'min' and 'maxlength' attributes to fields that require specific length" do
    input = @builder.text_field(:name, :validate => true)
    
    input.should match(/min="3"/)
    input.should match(/maxlength="10"/)
    input.should match(/data-error-invalid-length="Invalid length"/)
  end
end