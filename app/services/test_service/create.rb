module TestService
  class Create < BaseService
    def initialize(params)
      super
      @params = params
    end

    def call
      test = Test.new(@params)
      test.version = 1

      unless test.valid?
        return add_error("data not valid")
      end
      if test.save
        nil
      else
        add_error(test.errors.first)
      end
    end
  end
end
