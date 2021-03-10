class Post < ApplicationRecord
  belongs_to :profile

  validates :text, length: { maximum: 200 }
end
