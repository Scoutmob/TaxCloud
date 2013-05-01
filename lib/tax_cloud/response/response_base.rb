module TaxCloud

  class ResponseBase
    include TaxCloud::ResponseType

    # messages is an Array of ResponseMessage
    attr_accessor :messages

  end

end
