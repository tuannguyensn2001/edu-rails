# class BaseService
#   attr_reader :errors
#
#   def initialize(*_args)
#     @errors = []
#   end
#
#   def self.call(*args)
#     service = new(*args)
#     Rails.logger.info "capture call"
#     service.call
#     service
#   end
#
#   def success?
#     errors.empty?
#   end
#
#   def error?
#     !success?
#   end
#
#   def first_error
#     errors.first
#   end
#
#   private
#
#   def add_error(error)
#     @errors ||= []
#
#     case error
#     when StandardError, ActiveModel::Error
#       errors << error
#     when Array, ActiveModel::Errors
#       error.each { |e| add_error(e) }
#     else
#       errors << StandardError.new(error)
#     end
#   end
# end