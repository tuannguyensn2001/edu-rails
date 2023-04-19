module Contest
  class GetScore < BaseService
    def initialize(params)
      super
      @params = params
    end

    def call
      session = ContestSession.find( @params[:session_id])
      if session.user_id != @params[:user_id]
        add_error("forbidden")
        return
      end
      test = session.test
      score = 0
      if test.test_content.testable.instance_of?TestMultipleChoice
        answers = test.test_content.testable.test_multiple_choice_answers

        user_answers = session.answers
        map = {}
        user_answers.each do |user_answer|
          map[user_answer.question_id] = user_answer.answer
        end
        answers.each do |answer|
          if map[answer.id.to_s] == answer.answer
            score += answer.score
          end
        end
      end

      score

    rescue ActiveRecord::RecordNotFound
      add_error("not found")
    end
  end


end
