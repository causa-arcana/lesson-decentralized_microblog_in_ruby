class Followship < ApplicationRecord
  belongs_to :subject_profile, class_name: 'Profile'

  belongs_to :object_profile, class_name: 'Profile'

  validates :object_profile,
            exclusion: { in: ->(followship) { [followship.subject_profile] } },
            uniqueness: { scope: :subject_profile }
end
