class GroupsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_owner, only: [:edit, :update, :destroy]

  def say_hi
    puts "hello"
  end

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

  def edit
    respond_to do |format|
      format.json { render json: @group }
      format.html
    end
  end

  def update
    if @group.update(group_params)
      render json: { head: :ok }
    else
      render json: { errors: @group.errors.full_messages }
    end
  end

  def destroy
    @group.destroy
    redirect_to groups_path, alert: '討論版 已刪除!'
  end

  private

  def group_params
    params.require(:group).permit(:title, :description)
  end

  def authenticate_owner
    redirect_to groups_path, alert: 'You have no permission.' if current_user != @group.creator
  end

  def set_group
    @group = Group.find_by(id: params[:id])
    redirect_to groups_path, alert: "The group id doesn't exist." if @group == nil
  end
end
