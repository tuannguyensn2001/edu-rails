# frozen_string_literal: true
require "bcrypt"
module Auth
  class Register < BaseService
    include BCrypt
    def initialize(params)
      super
      @params = params
    end

    def call
      user = User.new(@params)
      return add_error("data not valid") unless user.valid?
      user.password = Password.create(@params[:password])
      user.save!
    end
  end

end