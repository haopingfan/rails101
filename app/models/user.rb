class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  has_many :groups
  has_many :posts
  has_many :group_users
  has_many :participated_groups, through: :group_users, source: :group

  def member_of?(group)
    participated_groups.include?(group)
  end

  def join!(group)
    participated_groups << group
  end

  def quit!(group)
    participated_groups.delete(group)
  end

  # --------  帳號整合 ----------
  has_many :identities

  def self.initialize_with_omniauth(auth)
    new(name: auth.info['name'], email: auth.info['email'], password: Devise.friendly_token[0, 20])
    # Devise.friendly_token[0, 20] generate a random 20 character,
    # it's designed to pass the password validation and maintain the cosistency
    # when user sign in/up through the 3rd party social site.
  end
end
