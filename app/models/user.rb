class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :registerable 

  ## Database authenticatable
  field :email,              :type => String, :default => ""
  field :encrypted_password, :type => String, :default => ""
  
  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  ## Confirmable
  # field :confirmation_token,   :type => String
  # field :confirmed_at,         :type => Time
  # field :confirmation_sent_at, :type => Time
  # field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time

  ## Token authenticatable
  # field :authentication_token, :type => String

  before_validation :beta_invited?

  has_many :evidence_files

  def beta_invited?
    unless self.class.dev_ids.include?(email)
    # unless BetaInvite.exists?(:email=>email)
      errors.add :email, "is not on our beta list"  
    end
  end 
  
  # List of admin users
  def self.dev_ids
    ['ben@benjaminolson.net','dontworryapp@gmail.com','forrestc@imach.com',
      'gorecki.matt@gmail.com','seanmcoan@gmail.com','jt.joel@gmail.com']
  end

  # Return true if the user is an admin
  def admin?
    self.class.dev_ids.include?(email)
  end

end
