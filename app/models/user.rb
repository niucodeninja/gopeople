class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, 
         :validatable, :lockable, :timeoutable,
         :confirmable, :token_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :authentication_token
  attr_accessible :name, :last_name, :birth_date

  # == Friendships
  has_many :friendships
  has_many :friends, :through => :friendships, :conditions => "status = 'accepted'"
  has_many :requested_friends, :through => :friendships, :source => :friend, :conditions => "status = 'requested'"
  has_many :pending_friends, :through => :friendships, :source => :friend, :conditions => "status = 'pending'"
end
