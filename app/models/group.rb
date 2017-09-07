class Group < ApplicationRecord
  validates :title, presence: true
  belongs_to :creator, class_name: 'User', foreign_key: :creator_id
  has_many :posts
end
