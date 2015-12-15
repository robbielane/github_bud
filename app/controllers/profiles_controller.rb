class ProfilesController < ApplicationController
  def show
    if current_user
      @user = current_user.details
      @repos = Repo.new(current_user).all
    end
  end
end
