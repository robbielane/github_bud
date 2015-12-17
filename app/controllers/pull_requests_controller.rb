class PullRequestsController < ApplicationController
  def index
    @pull_requests = PullRequest.new(current_user).all
  end

  def merge
    if PullRequest.new(current_user).merge(params[:repo], params[:pr_num])
      flash[:notice] = "Successfully merged"
      redirect_to :back
    else
      flash[:error] = "Sorry, something went wrong"
      redirect_to :back
    end
  end
end
