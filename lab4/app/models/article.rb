class Article < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :title, :content, presence: true
end
