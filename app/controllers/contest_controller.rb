class ContestController < ApplicationController
  def start
    request = params.permit(:user_id, :test_id)
    service = Contest::Start.new(request)
    service.call
    if service.error?
      render json: { message: service.errors.first }, status: :bad_request
    else
      render json: { message: 'ok' }
    end
  end
end
