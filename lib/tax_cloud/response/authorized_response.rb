module TaxCloud

  class AuthorizedResponse < ResponseBase

    def initialize(attrs = {})
      attrs.each do |sym, val|
        self.send "#{sym}=", val
      end
    end


  end

end
