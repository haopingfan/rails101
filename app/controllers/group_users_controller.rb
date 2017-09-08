class GroupUsersController < ApplicationController
  before_action :set_group
  before_action :authenticate_user!

  def create
    if current_user.member_of?(@group)
      flash[:warning] = '你已經是本版討論成員了！'
    else
      current_user.join!(@group)
      flash[:notice] = '加入本討論板成功！'
    end

    redirect_to group_path(@group)
  end

  def destroy
    if current_user.member_of?(@group)
      current_user.quit!(@group)
      flash[:alert] = '已退出本討論版！'
    else
      flash[:warning] = '你不是本討論板成員，怎麼退出啊XD'
    end

    redirect_to group_path(@group)
  end
end
