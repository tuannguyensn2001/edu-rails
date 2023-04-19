module Contest
  class Submit < BaseService
    def initialize(params)
      super
      @params = params
    end

    def call
      session = ContestSession.find(@params[:session_id])
      if session.user_id != @params[:user_id]
        return add_error("Forbidden")
      end
      if session.status == "END"
        return add_error("Submitted")
      end
      if session.deadline < Time.now.to_i
        return add_error("Late")
      end

      session.status = "END"
      session.save

    rescue ActiveRecord::RecordNotFound
      add_error("Not found")
    end
  end
end
