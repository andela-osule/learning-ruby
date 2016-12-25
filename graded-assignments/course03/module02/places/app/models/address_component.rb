class AddressComponent
    attr_reader :long_name
    attr_reader :short_name
    attr_reader :types

    def initialize(address)
        @long_name = address[:long_name] if address.key? :long_name
        @short_name = address[:short_name] if address.key? :short_name
        @types = address[:types] if address.key? :types
    end
end
