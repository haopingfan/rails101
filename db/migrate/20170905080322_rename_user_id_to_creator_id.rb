class RenameUserIdToCreatorId < ActiveRecord::Migration[5.1]
  def change
    rename_column :groups, :user_id, :creator_id
  end
end
