class User < ActiveRecord::Base
  # Devise supports
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, 
  :validatable, :lockable, :timeoutable,
  :confirmable, :token_authenticatable,
  :invitable, :invite_for => 2.weeks

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :authentication_token
  attr_accessible :name, :last_name, :birth_date, :invited_by_id

  # == Friendships
  has_many :friendships
  has_many :friends, :through => :friendships, :conditions => "status = 'accepted'"
  has_many :requested_friends, :through => :friendships, :source => :friend, :conditions => "status = 'requested'"
  has_many :pending_friends, :through => :friendships, :source => :friend, :conditions => "status = 'pending'"

  # == Invitations
  has_many :invitations, :class_name => 'User', :as => :invited_by_id
  before_invitation_accepted :before_user_invited_by
  after_invitation_accepted :after_user_invited_by
  
  # == Search
  def self.search(search)
    if search
      User.find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
    else
      User.find(:all)
    end
  end

  private

  # Event is fired after/before an invitation is accepted
  def before_user_invited_by
    Friendship.request(invited_by_id, self.id)
  end

  def after_user_invited_by
    Friendship.accept(self.id, invited_by_id)
  end
end
