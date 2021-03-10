class Profiles::FollowingController < ApplicationController
  before_action :set_profile

private

  def set_profile
    @profile = Profile.find params[:profile_id]
  end
end
