class Api::V0::UsersActivityCreationApiController < ActionController::API

  def create
    token = request.headers[:api_access_token] || request.headers[:HTTP_API_ACCESS_TOKEN]
    access_token = AccessToken.find_by(token: token)
    user_id = access_token.owner_id
    account = AccountUser.find_by(user_id: user_id, account_id: params[:account_id])

    inbox_id = params[:inbox_id]
    # render json: { inbox_id: inbox_id, ip: params[:remote_ip], url: params[:page_url] }, status: :created

    user_activity = UserActivity.find_by(
      ip_address: params[:remote_ip],
      account_id: params[:account_id],
      inbox_id: inbox_id
    )

    if user_activity.present?
      # Update the existing record
      user_activity.update(
        country: get_country_from_ip(params[:remote_ip]),
        previous_page: user_activity.page_url,
        page_url: params[:page_url],
        visited_at: DateTime.now
      )
    else
      # Create a new UserActivity record
      user_activity = UserActivity.new(
        country: get_country_from_ip(params[:remote_ip]),
        ip_address: params[:remote_ip],
        page_url: params[:page_url],
        visited_at: DateTime.now,
        account_id: params[:account_id],
        inbox_id: inbox_id
      )
    end

    if user_activity.save
      render json: user_activity, status: :created
    else
      render json: { error: 'Failed to create user' }, status: :internal_server_error
    end
  end

  def get_country_from_ip(remote_ip)
    return "PK"
  end
end
