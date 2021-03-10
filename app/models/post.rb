class Post < ApplicationRecord
  belongs_to :profile

  validates :text, presence: true, length: { maximum: 200 }

  validates :published_at, presence: true
end
