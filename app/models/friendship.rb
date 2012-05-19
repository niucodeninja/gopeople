class Friendship < ActiveRecord::Base
  attr_accessible :friend_id, :status, :user_id

  # == Friendship
  belongs_to :user 
  belongs_to :friend, :class_name => "User", :foreign_key => "friend_id"

  validates_presence_of :user_id, :friend_id

  # Return true if the users are (possibly pending) friends
  def exists?(user, friend)
    not find_by_user_id_and_friend_id(user, friend).nil?
  end

  # Record a pending friend request
  def request(user, friend)
    unless user == friend or Friendship.exists?(user, friend)
      transaction do
        create(:user => user, :friend => friend, :status => 'pending')
        create(:user => friend, :friend => user, :status => 'requested')
      end
    end
  end

  # Accept a friend request
  def accept(user, friend)
    transaction do 
      accept_one_side(user, friend)
      accept_one_side(friend, user)
    end 
  end

  # Delete a friendship or cancel a pending request
  def breakup(user, friend)
    transaction do 
      destroy(find_by_user_id_and_friend_id(user, friend)) 
      destroy(find_by_user_id_and_friend_id(friend, user))
    end 
  end

  private

  # Update the db with one side of an accepted friendship request
  def accept_one_side(user, friend)
    request = find_by_user_id_and_friend_id(user, friend) 
    request.status = 'accepted' 
    request.save!
  end
end