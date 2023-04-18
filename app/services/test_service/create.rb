module TestService
  class Create < BaseService
    def initialize(params)
      super
      @params = params
    end

    def call
      test = Test.new(@params.merge(version: 1))

      if test.save
        test
      else
        add_error("data not valid")
      end
    end
  end
end
