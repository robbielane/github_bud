class ProfilesController < ApplicationController
  def show
    if current_user
      @repos = Repo.new(current_user)
      @stats = Contributions.new(current_user)
      @events = Event.new(current_user)
    end
  end
end
