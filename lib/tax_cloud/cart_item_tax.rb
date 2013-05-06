module TaxCloud
  class CartItemTax
    attr_reader :cart_item_index, :amount

    def initialize(attrs = {})
      @cart_item_index = attrs[:cart_item_index]
      @amount = attrs[:tax_amount].to_f
    end

  end
end

