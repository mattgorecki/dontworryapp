class BetaSignup
  include Mongoid::Document
  field :email, type: String
  field :invited, type: Boolean

  validates_uniqueness_of :email , :message => "already exists"  
  validates :email,   
          presence: true,   
          format: { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
end
