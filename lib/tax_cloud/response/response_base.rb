module TaxCloud

  class ResponseBase
    include TaxCloud::ResponseType

    def initialize(attrs={})
      @response_type = attrs[:response_type]
      @raw_messages = attrs[:messages]
    end

    # An Array of ResponseMessage
    def messages
      @messages ||= parse_messages(@raw_messages)
    end

    protected
    def parse_messages(raw_messages)
      if raw_messages.nil?
        []
      else
        messages = raw_messages[:response_message]
        messages = [messages].flatten # possibly an array or a single element
        messages.collect{|m| TaxCloud::ResponseMessage.new(m) }
      end
    end

  end

end
