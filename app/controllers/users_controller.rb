class UsersController < ApplicationController

  def search
    @people = User.search(params[:q])
  end

end
