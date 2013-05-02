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
  extend self

  WSDL = 'https://api.taxcloud.net/1.0/TaxCloud.asmx?wsdl'

  # Configuration pattern more-or-less copied shamelessly from Resque
  Config = Struct.new :api_id, :api_key, :customer_id

  def config
    @config ||= Config.new
  end

  def configure
    yield config
  end

  def authorized_with_capture(customer_id, cart_id, order_id, date_authorized, date_captured)
    date_authorized = date_authorized.utc.iso8601
    date_captured = date_captured.utc.iso8601
    authorized_service.authorized_with_capture(config.api_id, config.api_key, customer_id, cart_id, order_id, date_authorized, date_captured)
  end

  def authorized(customer_id, cart_id, order_id, date_authorized)
    date_authorized = date_authorized.utc.iso8601
    authorized_service.authorized(config.api_id, config.api_key, customer_id, cart_id, order_id, date_authorized)
  end

  def captured(order_id)
    authorized_service.captured(config.api_id, config.api_key, order_id)
  end

  def lookup(customer_id, cart_id, origin, destination, cart_items)
    lookup_service.lookup(config.api_id, config.api_key, customer_id, cart_id, origin, destination, cart_items)
  end

  def returned(order_id, cart_items, returned_date)
    returned_date = returned_date.utc.iso8601
    returned_service.returned(config.api_id, config.api_key, order_id, cart_items, returned_date)
  end

  def get_tics
    tic_service.get_tics(config.api_id, config.api_key)
  end

  def get_tic_groups
    tic_service.get_tic_groups(config.api_id, config.api_key)
  end

  def get_tics_by_group(group_id)
    tic_service.get_tics_by_group(config.api_id, config.api_key, group_id)
  end

  def verify_address(address)
    raise 'A USPS ID is required to verify addresses.' if config.usps_id.nil?
    verify_address_service.verify_address(config.api_id, config.api_key, config.usps_id, address)
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
    @returned_service ||= TaxCloud::ReturnedService.new client
  end

  def tic_service
    @tic_service ||= TaxCloud::TICService.new client
  end

  def verify_address_service
    @verify_address_service ||= TaxCloud::VerifyAddressService.new client
  end

end

