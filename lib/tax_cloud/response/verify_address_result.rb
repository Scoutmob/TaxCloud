require 'tax_cloud/response/response_base'
require 'tax_cloud/address'

module TaxCloud
  class VerifyAddressResult < ResponseBase
    attr_reader :address1, :address2, :city, :state, :zip5, :zip4

    def initialize(attrs = {})
      @address1 = attrs[:address1]
      @address2 = attrs[:address2]
      @city = attrs[:city]
      @state = attrs[:state]
      @zip5 = attrs[:zip5]
      @zip4 = attrs[:zip4]

      # Translate err_number / err_description into ResponseMessage formats
      if '0' == attrs[:err_number]
        attrs[:response_type] = TaxCloud::ResponseType::OK
      else
        attrs[:response_type] = TaxCloud::ResponseType::ERROR
        attrs[:messages] = {
          response_message: {
            response_type: TaxCloud::ResponseType::ERROR,
            message: "Error #{attrs[:err_number]}: #{attrs[:err_description]}"
          }
        }
      end

      super
    end

    def address
      @address ||= TaxCloud::Address.new(:address1 => @address1, :address2 => @address2, :city => @city, :state => @state, :zip5 => @zip5, :zip4 => @zip4)
    end

  end
end

