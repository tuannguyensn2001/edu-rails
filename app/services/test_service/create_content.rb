module TestService
  class CreateContent < BaseService
    def initialize(params)
      super
      @params = params
    end

    def call
      begin
        test = Test.find(@params[:test_id])
      rescue ActiveRecord::RecordNotFound
        add_error('Test not found')
        return
      end

      ActiveRecord::Base.transaction do

        test_multiple_choice = TestMultipleChoice.new file_path: @params[:multiple_choice][:file_path], score: @params[:multiple_choice][:score]
        test_multiple_choice.save!
        answers = []

        @params[:multiple_choice][:answers].each do |answer|
          answers << { answer: answer[:answer], score: answer[:score], test_multiple_choice_id: test_multiple_choice.id }
        end

        TestMultipleChoiceAnswer.create! answers

        if TestContent.find_by(test_id: test.id).present?
          TestContent.find_by(test_id: test.id).update(testable_id: test_multiple_choice.id)
        else
          test_multiple_choice.test_content = TestContent.new test_id: test.id
        end
        test_multiple_choice.save!

      end
    rescue ActiveRecord::RecordInvalid
      add_error('Invalid data')
    end
  end
end
