require 'tax_cloud/service/base_service'

module TaxCloud
  class BaseService
    attr_accessor :client

    def initialize(client)
      self.client = client
    end

  end
end

