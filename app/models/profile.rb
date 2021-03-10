class Profile < ApplicationRecord
  has_many :posts

  def full_name
    [first_name, last_name].map(&:presence).compact.join(' ').presence ||
      "Profile#{" ##{id}" if id.present?}"
  end
end
