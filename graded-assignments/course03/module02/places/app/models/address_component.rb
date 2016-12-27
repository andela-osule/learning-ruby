class AddressComponent
    attr_reader :long_name
    attr_reader :short_name
    attr_reader :types

    def initialize(address)
        @long_name = address[:long_name] unless address[:long_name].nil?
        @short_name = address[:short_name] unless address[:short_name].nil?
        @types = address[:types] unless address[:types].nil?
    end
end
