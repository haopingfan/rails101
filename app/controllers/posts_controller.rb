class PostsController < ApplicationController
  before_action :set_group
  before_action :authenticate_member

  def new
    @post = Post.new
  end

  def create
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

  def authenticate_member
    redirect_to group_path(@group), alert: '要先加入群組才能發表文章' if !(current_user && current_user.member_of?(@group))
    # 用current_user先判斷是否為nil, 使用者為登出狀態訪問此頁面時, 就不會跳紅畫面
  end

  def set_group
    @group = Group.find_by(id: params[:group_id])
    redirect_to groups_path, alert: "The group id doesn't exist." if @group == nil
  end
end
