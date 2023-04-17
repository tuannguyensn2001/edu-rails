class ApplicationController < ActionController::API
  # rescue_from Exception:
  rescue_from Exception, :with => :handle_exception

  def handle_exception(error)
    Rails.logger.error error
    render json: {message: error}
  end

end
