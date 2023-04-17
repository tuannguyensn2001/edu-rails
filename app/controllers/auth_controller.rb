# class AuthController < ApplicationController
#   def register
#     request = params.permit(:email, :password, :username)
#
#     service = Auth::Register.new(request)
#     service.call
#     if service.errors.any?
#       render json: {message: service.errors}, status: :bad_request
#       return
#     end
#
#     render json: {message: "success"}
#
#   end
# end
