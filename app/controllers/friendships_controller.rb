class FriendshipsController < ApplicationController
  
  before_filter :authenticate_user!
  
  def index
    if current_user == params[:user_id]
      @user = current_user
      @friends = @user.friends
    else
      user = User.find(params[:user_id])
      if user
        @user = user
        @friends = @user.friends
      end
    end
  end
  
  def requests
  end

  def invites
  end
end
