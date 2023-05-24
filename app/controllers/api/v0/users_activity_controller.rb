# class Api::V0::UsersActivityController < ApplicationController
class Api::V0::UsersActivityController < Api::V1::Accounts::BaseController
  before_action :current_account

  def inboxes
    channel_ids = Channel::WebWidget.where(account_id: Current.account.id).pluck(:id)
    inboxes = Inbox.where(channel_type: "Channel::WebWidget", channel_id: channel_ids)
    render json: inboxes
  end

  def get
    user_activities = UserActivity.where(
      inbox_id: params[:inbox_id],
      account_id: Current.account.id
    )
    render json: user_activities
  end
end
