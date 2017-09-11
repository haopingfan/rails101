class Account::PostsController < ApplicationController
  def index
    @posts = current_user.posts.recent.paginate(page: params[:page], per_page: 5)
  end
end
