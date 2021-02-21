class Feed < ApplicationRecord
  validates :image, presence: true
  mount_uploader :image, ImageUploader
  belongs_to :user
  has_many :comments
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
end
