class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :feed
  validates :content, length: {maximum: 100}
end
