module TaxCloud

  require 'tax_cloud/tic'

  class GetTICsResponse < ResponseBase

    def initialize(attrs = {})
      @raw_tics = attrs[:ti_cs]
      super
    end

    def tics
      @tics ||= parse_tics(@raw_tics)
    end

    protected
    def parse_tics(raw_tics)
      if raw_tics.nil?
        []
      else
        raw_tics[:tic].collect do |tic|
          TaxCloud::TIC.new(tic)
        end
      end
    end

  end
end
