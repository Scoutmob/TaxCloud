require 'tax_cloud/response/response_base'
require 'tax_cloud/tic_group'

module TaxCloud
  class GetTICGroupsResponse < ResponseBase

    def initialize(attrs = {})
      @raw_tic_groups = attrs[:tic_groups]
      super
    end

    def tic_groups
      @tic_groups ||= parse_tic_groups(@raw_tic_groups)
    end

    protected
    def parse_tic_groups(raw_tic_groups)
      if raw_tic_groups.nil?
        []
      else
        raw_tic_groups[:tic_group].collect{|g| TaxCloud::TICGroup.new(g)}
      end
    end

  end
end

