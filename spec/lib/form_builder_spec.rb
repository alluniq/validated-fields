require "spec_helper"

describe ValidatedFields::FormBuilder do

  before(:each) do
    @user       = User.new
    @controller = UsersController.new
    @builder    = ValidatedFields::FormBuilder.new(:user, @user, @controller, {}, nil)
  end

  it "should be the default form builder" do
    ActionView::Base.default_form_builder.should == ValidatedFields::FormBuilder
  end

  it "should add 'validated' class if there's no class in options" do
    @builder.text_field(:name, :validate => true).should match(/class="validated"/)
  end

  it "should add 'validated' class if the 'class' option already has a value assigned" do
    @builder.text_field(:name, :validate => true, :class => 'foobar').should match(/class="foobar validated"/)
  end

  it "should not add any options if the :validate option isn't provided" do
    input = @builder.text_field(:name)

    input.should_not match(/required="required"/)
    input.should_not match(/data-required-error-msg="Name is required"/)
    input.should_not match(/validate="false"/)
    input.should_not match(/class="validated"/)
  end

  it "should add options if the :if Proc returns true" do
    @user.name = "Joe"
    input = @builder.text_field(:last_name, :validate => true)

    input.should match(/required="required"/)
    input.should match(/class="validated"/)
  end

  it "should not add any options if the :if Proc returns false" do
    input = @builder.text_field(:last_name, :validate => true)

    input.should_not match(/required="required"/)
    input.should_not match(/class="validated"/)
  end

  it "should add options if the method assigned to :if returns true" do
    @user.last_name = "Doe"
    input = @builder.text_field(:maiden_name, :validate => true)

    input.should match(/required="required"/)
    input.should match(/class="validated"/)
  end

  it "should not add any options if the method assigned to :if returns false" do
    input = @builder.text_field(:maiden_name, :validate => true)

    input.should_not match(/required="required"/)
    input.should_not match(/class="validated"/)
  end

  it "should add data-validates with validator names" do
    input1 = @builder.text_field(:name,  :validate => true)
    input2 = @builder.text_field(:email, :validate => true)

    input1.should match(/data-validates="presence length"/)
    input2.should match(/data-validates="format"/)
  end

  it "should not add data-validates for fields that are not validated" do
    input = @builder.text_field(:city, :validate => true)
    input.should_not match(/data-validates/)
  end

  it "should add a wrapper for radio buttons" do
    group = @builder.radio_buttons(:name, :validate => true) { "foobar" }
    group = group.to_str

    group.should match(/<div /)
    group.should match(/>foobar</)
    group.should match(/data-validates="presence length"/)
    group.should match(/class="validated radio"/)
  end

  it "should add a wrapper for check boxes" do
    group = @builder.check_boxes(:name, :validate => true) { "foobar" }
    group = group.to_str

    group.should match(/<div /)
    group.should match(/>foobar</)
    group.should match(/data-validates="presence length"/)
    group.should match(/class="validated checkboxes"/)
  end
end