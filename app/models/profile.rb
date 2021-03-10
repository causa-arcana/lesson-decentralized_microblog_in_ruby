class Profile < ApplicationRecord
  has_many :posts

  has_many :outgoing_followships,
           class_name: 'Followship',
           foreign_key: :subject_profile_id

  has_many :incoming_followships,
           class_name: 'Followship',
           foreign_key: :object_profile_id

  has_many :followed_profiles,
           class_name: 'Profile',
           through: :outgoing_followships,
           source: :object_profile

  has_many :following_profiles,
           class_name: 'Profile',
           through: :incoming_followships,
           source: :subject_profile

  def full_name
    [first_name, last_name].map(&:presence).compact.join(' ').presence ||
      "Profile#{" ##{id}" if id.present?}"
  end
end
