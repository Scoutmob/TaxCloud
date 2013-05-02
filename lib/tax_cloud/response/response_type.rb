module TaxCloud
  module ResponseType

    ERROR = 'Error'
    WARNING = 'Warning'
    INFORMATIONAL = 'Informational'
    OK = 'OK'

    attr_accessor :response_type

    def ok?
      @response_type == OK
    end

    def warning?
      @response_type == WARNING
    end

    def informational?
      @response_type == INFORMATIONAL
    end

    def error?
      @response_type == ERROR
    end

  end
end

