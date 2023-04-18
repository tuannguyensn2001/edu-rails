class TestController < ApplicationController
  def create
    request = params.permit(:name, :time_to_do, :time_start)
    service = TestService::Create.new(request)

    service.call
    if service.error?
      render json: { errors: service.errors.first }, status: :bad_request
    else
      render json: { message: 'ok' }
    end
  end

  def create_content
    Rails.logger.info params
    request = params.permit(
      :test_id,
      :typeable,
      multiple_choice: [
        :file_path,
        :score,
        answers: [
          :answer,
          :score,
          :type
        ]
      ]
    )
    service = TestService::CreateContent.new(request)
    service.call
    if service.error?
      render json: { errors: service.errors.first }, status: :bad_request
    else
      render json: { message: 'ok' }
    end
  end
end
