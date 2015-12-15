class ProfilesController < ApplicationController
  def show
    if current_user
      @github = Github.new(current_user)
    end
  end
end
