class ReposController < ApplicationController
  def show
    if current_user
      @repo = Repo.new(current_user, params[:repo])
    end
  end
end
