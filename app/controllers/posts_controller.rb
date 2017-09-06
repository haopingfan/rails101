class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def new
    @group = Group.find(params[:group_id])
    @post = Post.new
  end

  def create
    @group = Group.find(params[:group_id])
    @post = @group.posts.new(post_params)
    @post.user = current_user

    if @post.save
      redirect_to group_path(@group), notice: '文章 新建成功!'
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
