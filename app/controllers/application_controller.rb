class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def set_group
    @group = Group.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to groups_path, alert: "The group id doesn't exist."
  end
end
