class Group < ApplicationRecord
  validates :title, presence: true
  belongs_to :creator, class_name: 'User', foreign_key: :user_id
  has_many :posts
  has_many :group_users
  has_many :members, through: :group_users, source: :user
end
