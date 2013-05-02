require 'savon/client'
require 'tax_cloud/address'
require 'tax_cloud/cart_item_tax'
require 'tax_cloud/cartitem'
require 'tax_cloud/tic'
require 'tax_cloud/tic_group'
require 'tax_cloud/service/tic_service'
require 'tax_cloud/service/lookup_service'
require 'tax_cloud/service/authorized_service'
require 'tax_cloud/service/returned_service'
require 'tax_cloud/service/verify_address_service'

module TaxCloud

  class Base
    WSDL = 'https://api.taxcloud.net/1.0/TaxCloud.asmx?wsdl'

    ##
    # Creates a new API wrapper with the given +api_id+, +api_key+, and 
    # (optionally) +usps_id+. The +usps_id+ is only necessary if you plan on
    # using the address verification service.
    def initialize(api_id, api_key, usps_id=nil)
      @api_id = api_id
      @api_key = api_key
      @usps_id = usps_id
    end

    def authorized_with_capture(customer_id, cart_id, order_id, date_authorized, date_captured)
      date_authorized = date_authorized.utc.iso8601
      date_captured = date_captured.utc.iso8601
      authorized_service.authorized_with_capture(@api_id, @api_key, customer_id, cart_id, order_id, date_authorized, date_captured)
    end

    def authorized(customer_id, cart_id, order_id, date_authorized)
      date_authorized = date_authorized.utc.iso8601
      authorized_service.authorized(@api_id, @api_key, customer_id, cart_id, order_id, date_authorized)
    end

    def captured(order_id)
      authorized_service.captured(@api_id, @api_key, order_id)
    end

    def lookup(customer_id, cart_id, origin, destination, cart_items)
      lookup_service.lookup(@api_id, @api_key, customer_id, cart_id, origin, destination, cart_items)
    end

    def returned(order_id, cart_items, returned_date)
      returned_date = returned_date.utc.iso8601
      returned_service.returned(@api_id, @api_key, order_id, cart_items, returned_date)
    end

    def get_tics
      tic_service.get_tics(@api_id, @api_key)
    end

    def get_tic_groups
      tic_service.get_tic_groups(@api_id, @api_key)
    end

    def get_tics_by_group(group_id)
      tic_service.get_tics_by_group(@api_id, @api_key, group_id)
    end

    def verify_address(address)
      raise 'A USPS ID is required to verify addresses.' if @usps_id.nil?
      verify_address_service.verify_address(@api_id, @api_key, @usps_id, address)
    end

    protected
    def client
      @client ||= Savon::Client.new(WSDL)
    end

    def lookup_service
      @lookup_service ||= TaxCloud::LookupService.new client
    end

    def authorized_service
      @authorized_service ||= TaxCloud::AuthorizedService.new client
    end

    def returned_service
      @returned_service = TaxCloud::ReturnedService.new client
    end

    def tic_service
      @tic_service = TaxCloud::TICService.new client
    end

    def verify_address_service
      @verify_address_service = TaxCloud::VerifyAddressService.new client
    end

  end

end

