module Auth
  class GetMe < BaseService
    def initialize(user_id)
      super
      @user_id = user_id
    end

    def call
       User.find(@user_id)
    rescue ActiveRecord::RecordNotFound
      add_error("User not found")
    end
  end
end