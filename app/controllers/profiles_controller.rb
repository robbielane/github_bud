class ProfilesController < ApplicationController
  def show
    if current_user
      @repos = Repo.new(current_user).all
      @stats = Github.new(current_user)
    end
  end
end
