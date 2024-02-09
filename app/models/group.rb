class Group < ApplicationRecord
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  has_many :group_memberships, dependent: :destroy
  has_many :members, through: :group_memberships, source: :user

  validates :name, presence: true, length: { maximum: 50 }
end
