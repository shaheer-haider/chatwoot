class Api::V0::UsersActivityController < Api::V1::Accounts::BaseController

  def inboxes
    channel_ids = Channel::WebWidget.where(account_id: Current.account.id).pluck(:id)
    inboxes = Inbox.where(channel_type: "Channel::WebWidget", channel_id: channel_ids)
    render json: inboxes
  end

  def get
  end

  def create
  end

end
