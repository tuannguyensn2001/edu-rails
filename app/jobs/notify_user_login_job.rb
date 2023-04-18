class NotifyUserLoginJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    echo "Hello World"
  end
end
