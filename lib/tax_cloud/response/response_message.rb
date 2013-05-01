module TaxCloud

  class ResponseMessage
    include TaxCloud::ResponseType

    # message is a string
    attr_accessor :message
  end

end
