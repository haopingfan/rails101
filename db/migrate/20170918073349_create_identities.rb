class CreateIdentities < ActiveRecord::Migration[5.1]
  def change
    create_table :identities do |t|
      t.string :provider, null: false
      t.string :uid, null: false
      t.integer :user_id, null: false
      t.index([:provider, :uid], unique: true)

      t.timestamps
    end
  end
end
