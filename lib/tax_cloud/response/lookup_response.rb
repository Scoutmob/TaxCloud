require 'tax_cloud/response/response_base'
require 'tax_cloud/cart_item_tax'

module TaxCloud
  class LookupResponse < ResponseBase
    attr_reader :cart_id

    def initialize(attrs = {})
      @cart_id = attrs[:cart_id]
      @raw_cart_items_response = attrs[:cart_items_response]
      super
    end

    def taxes
      @taxes ||= parse_cart_items_response(@raw_cart_items_response)
    end

    protected
    def parse_cart_items_response(raw_cart_items_response)
      if raw_cart_items_response.nil?
        []
      else
        items = raw_cart_items_response[:cart_item_response]
        items = [items].flatten # may be single element or array.
        items.collect{|tax| TaxCloud::CartItemTax.new(tax)}
      end
    end

  end
end

