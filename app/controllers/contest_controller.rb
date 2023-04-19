class ContestController < ApplicationController
  before_action :authentication

  def start
    request = params.permit(:test_id)
    request = request.merge(user_id: @user_id)
    service = Contest::Start.new(request)
    session = service.call
    if service.error?
      render json: { message: service.errors.first }, status: :bad_request
    else
      render json: { message: 'ok', data: session }
    end
  end

  def answer
    request = params.permit(:session_id, :question_id, :answer).merge(user_id: @user_id)
    service = Contest::Answer.new(request)
    service.call
    if service.error?
      render json: { message: service.errors.first }, status: :bad_request
    else
      render json: { message: 'ok' }
    end
  end
end
