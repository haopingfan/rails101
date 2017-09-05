class GroupsController < ApplicationController
  before_action :find_group_by_id, only: [:show, :edit, :update, :destroy]

  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)

    if @group.save
      redirect_to groups_path, notice: '討論板 新建成功!'
    else
      render :new
    end
  end

  def show; end

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

  private

  def group_params
    params.require(:group).permit(:title, :description)
  end

  def find_group_by_id
    @group = Group.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to groups_path, alert: "The group id doesn't exist."
  end
end
