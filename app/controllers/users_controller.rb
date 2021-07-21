class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
    @pending_inviters = current_user.pending_inviters
    @pending_invitees = current_user.pending_invitees
    # TODO => Fix layout + pivot
    @accepted_friends = current_user.accepted_friends
  end
end
