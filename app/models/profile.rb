class Profile < ApplicationRecord
  has_many :posts

  has_many :outgoing_followships,
           class_name: 'Followship',
           foreign_key: :subject_profile_id

  has_many :incoming_followships,
           class_name: 'Followship',
           foreign_key: :object_profile_id

  def full_name
    [first_name, last_name].map(&:presence).compact.join(' ').presence ||
      "Profile#{" ##{id}" if id.present?}"
  end
end
