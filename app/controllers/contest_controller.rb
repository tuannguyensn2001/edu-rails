class ContestController < ApplicationController
  before_action :authentication, only: [:start]

  def start
    request = params.permit(:test_id)
    request = request.merge(user_id: @user_id)
    service = Contest::Start.new(request)
    service.call
    if service.error?
      render json: { message: service.errors.first }, status: :bad_request
    else
      render json: { message: 'ok' }
    end
  end
end
