require "bcrypt"
require "jwt"
module Auth
  class Login < BaseService
    attr_reader :params

    def initialize(params, secret = Rails.application.config.secret_key)
      super
      @params = params
      @secret = secret
    end

    def call

      user = User.find_by(email: @params[:email])
      if user == nil
        add_error("username or password not valid")
        return
      end
      unless compare(@params[:password], user.password)
        add_error("username or password not valid")
        return
      end

      payload = {
        data: {
          user_id: user.id
        },
        exp: 24.hours.from_now.to_i
      }
      access_token = generate_token(payload)
      payload[:exp] = 48.hours.from_now.to_i
      refresh_token = generate_token(payload)
      NotifyUserLoginJob.perform_later(user.id)
      { access_token: access_token, refresh_token: refresh_token }
    end

    def compare(password, hash_password)
      BCrypt::Password.new(hash_password) == password
    end

    def generate_token(params)
      JWT.encode(params, @secret)
    end
  end

end