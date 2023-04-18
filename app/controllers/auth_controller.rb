class AuthController < ApplicationController

  before_action :authentication, only: [:get_me]
  def register
    request = params.permit(:email, :password, :username)

    service = Auth::Register.new(request)
    service.call
    if service.errors.any?
      render json: {message: service.errors}, status: :bad_request
      return
    end

    render json: { message: "success" }

  end

  def login
    request = params.permit(:email, :password)

    service = Auth::Login.new(request)
    result = service.call
    if service.errors.any?
      render json: { message: service.errors.first }, status: :bad_request
      return
    end

    render json: { message: "success", data: result }
  end

  def get_me
    service = Auth::GetMe.new(@user_id)
    user = service.call
    if service.errors.any?
      render json: { message: service.errors }, status: :bad_request
      return
    end
    resp = {
      message: "success",
      data: user
    }
    render json: resp, :except=> [:password]
  end
end
