class Place
    attr_accessor :id
    attr_accessor :formatted_address
    attr_accessor :location
    attr_accessor :address_components

    def initialize(place)
        @id = place[:_id].to_s
        @location = Point.new(place[:geometry][:location])

        @address_components = []
        place[:address_components].reduce([]){|memo,chunk| @address_components<< AddressComponent.new(chunk)}
        
        @formatted_address = place[:formatted_address]     
    end

    def self.mongo_client
        Mongoid::Clients.default    
    end
    
    def self.collection
        mongo_client[:places]
    end

    def self.load_all(f)
        collection.insert_many(JSON.parse(f.read))    
    end
end