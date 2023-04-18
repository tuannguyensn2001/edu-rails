class ApplicationController < ActionController::API
  # rescue_from Exception:
  rescue_from Exception, :with => :handle_exception

  def handle_exception(error)
    Rails.logger.error error
    render json: {message: error}, status: :internal_server_error
  end

  def authentication
    token = request.headers['Authorization']
    unless token
      render json: { errors: 'Token not found' }, status: :unauthorized
      return
    end
    unless token.match(/^Bearer (.+)/)
      render json: { errors: 'Token not valid' }, status: :unauthorized
      return
    end
    token = $1
    Rails.logger.info "token #{token}"
    service = Auth::Verify.new(token)

    result = service.call
    if service.errors.any?
      render json: { errors: service.errors }, status: :bad_request
      return
    end
    data = result[0]["data"]
    @user_id = data["user_id"]
  end

end
