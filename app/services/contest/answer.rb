module Contest
  class Answer < BaseService
    def initialize(params)
      super
      @params = params
    end

    def call
      session = ContestSession.find(@params[:session_id])
      if session.user_id != @params[:user_id]
        return add_error("Forbidden")
      end
      if session == nil
        return add_error("Session not found")
      end
      if session.status == "END"
        return add_error("Session ended")
      end
      if session.deadline < Time.now.to_i
        return add_error("Session ended")
      end
      answer = ContestAnswer.find_by(session_id: session.id, question_id: @params[:question_id])
      if answer != nil
        if answer.answer != @params[:answer]
          ContestAnswer.update(session_id: session.id, question_id: @params[:question_id], answer: @params[:answer])
        end
        return
      end
      answer = ContestAnswer.create(session_id: session.id, question_id: @params[:question_id], answer: @params[:answer])
      unless answer.valid?
        return add_error("data not valid")
      end
      answer
    rescue ActiveRecord::RecordNotFound
      add_error("Not found")
    end
  end
end
