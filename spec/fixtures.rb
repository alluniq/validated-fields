class UsersController < ActionController::Base
  include ActionView::Helpers::FormHelper
  include ValidatedFields::Helpers
end

class User
  include ActiveModel::Validations
  extend  ActiveModel::Naming
      
  attr_accessor :name, :email, :age
  
  validates :name,  :presence => {:message => 'Name is required'},
                    :length   => {:minimum => 3, :maximum => 10, :message => 'Invalid length'}
                    
  validates :email, :format   => {:message => "Email is required", :with   => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}
  
  def model_name
    "user"
  end
  
  def to_model
    self
  end
end
