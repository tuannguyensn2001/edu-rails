module Contest
  class Start < BaseService
    def initialize(params)
      super
      @params = params
    end

    def call
      if ContestSession.find_by(user_id: @params[:user_id], test_id: @params[:test_id])
        return add_error("Already started")
      end
      test = Test.find(@params[:test_id])
      if test.time_start != nil
        if Time.at(test.time_start) > Time.now
          return add_error("Contest not started")
        end
      end

      if test.time_end != nil
        if Time.now.to_i > test.time_end - (test.time_to_do * 60)
          return add_error("Contest ended")
        end
      end

      session = ContestSession.create(user_id: @params[:user_id], test_id: @params[:test_id], session_code: SecureRandom.uuid, status: "START")
      unless session.valid?
        return add_error("data not valid")
      end
      session
    rescue ActiveRecord::RecordNotFound
      add_error("Not found")
    end
  end
end
