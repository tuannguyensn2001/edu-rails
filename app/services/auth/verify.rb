module Auth
  class Verify  < BaseService
    def initialize(token,secret = Rails.application.config.secret_key)
      super
      @token = token
      @secret = secret
    end

    def call
      JWT.decode(@token,@secret,true)
    end
  end
end
