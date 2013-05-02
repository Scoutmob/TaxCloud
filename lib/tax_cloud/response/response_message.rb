require 'tax_cloud/response/response_type'

module TaxCloud
  class ResponseMessage
    include TaxCloud::ResponseType

    # message is a string
    attr_reader :message

    def initialize(attrs={})
      @response_type = attrs[:response_type]
      @message = attrs[:message]
    end

  end
end

