class CreateIdentities < ActiveRecord::Migration[5.1]
  def change
    create_table :identities do |t|
      t.string :provider, null: false, index: true
      t.string :uid, null: false, index: true
      t.integer :user_id, null: false

      t.timestamps
    end
  end
end
