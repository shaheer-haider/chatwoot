class UserActivitiesChannel < ApplicationCable::Channel
  def subscribed
    stream_for params[:inbox_id]
  end
end

