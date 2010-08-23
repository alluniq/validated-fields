class UsersController < ActionController::Base
  include ActionView::Helpers::FormHelper
  include ValidatedFields::Helpers
end

class User
  include ActiveModel::Validations
  extend  ActiveModel::Naming
      
  attr_accessor :name, :last_name, :maiden_name, :email, :age
  
  validates :name,  :presence => {:message => 'Name is required'},
                    :length   => {:minimum => 3, :maximum => 10, :message => 'Invalid length'}
                    
  validates :email, :format   => {:message => "Email is required", :with   => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}
  
  validates :age, :numericality => {
    :message      => "Wrong number format",
    :greater_than => 0,
    :less_than    => 10
  }
  
  validates :last_name,   :presence => {:if => Proc.new {|user| !user.name.nil?}}
  validates :maiden_name, :presence => {:if => :has_last_name}
  
  def model_name
    "user"
  end
  
  def to_model
    self
  end
  
  def has_last_name
    !self.last_name.nil?
  end
end
