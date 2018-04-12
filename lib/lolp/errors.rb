module Lolp
  class Error < StandardError
    class << self
      def from_response(r)
        if klass = case r.status.to_i
            when 400      then BadRequest
            when 401      then Unauthorized
            when 402      then PaymentRequired
            when 403      then Forbidden
            when 404      then NotFound
            when 406      then NotAcceptable
            when 409      then Conflict
            when 429      then TooManyRequests
            when 422      then UnprocessableEntity
            when 400..499 then ClientError
            when 500      then InternalServerError
            when 501      then NotImplemented
            when 502      then BadGateway
            when 503      then ServiceUnavailable
            when 500..599 then ServerError
            end
          klass.new(build_error_message(r))
        end
      end

      def build_error_message(res = nil)
        return nil if res.nil?
        message =  "#{res.env.method.to_s.upcase} "
        message << "#{res.env.url}: "
        message << "#{res.status} - "
        message << "#{res.body}" if res.body
        message
      end
    end
  end

  class BadRequest < Error; end
  class Unauthorized < Error; end
  class PaymentRequired < Error; end
  class Forbidden < Error; end
  class NotFound < Error; end
  class NotAcceptable < Error; end
  class Conflict < Error; end
  class TooManyRequests; end
  class UnprocessableEntity < Error; end
  class ClientError < Error; end

  class InternalServerError < Error; end
  class NotImplemented < Error; end
  class BadGateway < Error; end
  class ServiceUnavailable < Error; end
  class ServerError < Error; end
end

