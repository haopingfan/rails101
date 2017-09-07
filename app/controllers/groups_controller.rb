class GroupsController < ApplicationController
  before_action :find_group_by_id, only: [:show, :edit, :update, :destroy, :join, :quit]
  before_action :authenticate_user!, only: [:new, :create, :join, :quit]
  before_action :authenticate_owner, only: [:edit, :update, :destroy]

  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def create
    @group = current_user.groups.new(group_params)

    if @group.save
      current_user.join!(@group)
      redirect_to groups_path, notice: '討論板 新建成功!'
    else
      render :new
    end
  end

  def show
    @posts = @group.posts.recent.paginate(page: params[:page], per_page: 5)
  end

  def edit; end

  def update
    if @group.update(group_params)
      redirect_to groups_path, notice: '討論版 更新成功!'
    else
      render :edit
    end
  end

  def destroy
    @group.destroy
    redirect_to groups_path, alert: '討論版 已刪除!'
  end

  def join
    if current_user.member_of?(@group)
      flash[:warning] = '你已經是本版討論成員了！'
    else
      current_user.join!(@group)
      flash[:notice] = '加入本討論板成功！'
    end

    redirect_to group_path(@group)
  end

  def quit
    if current_user.member_of?(@group)
      current_user.quit!(@group)
      flash[:alert] = '已退出本討論版！'
    else
      flash[:warning] = '你不是本討論板成員，怎麼退出啊XD'
    end

    redirect_to group_path(@group)
  end

  private

  def group_params
    params.require(:group).permit(:title, :description)
  end

  def find_group_by_id
    @group = Group.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to groups_path, alert: "The group id doesn't exist."
  end

  def authenticate_owner
    redirect_to groups_path, alert: 'You have no permission.' if current_user != @group.creator
  end
end
