class Place
    attr_accessor :id
    attr_accessor :formatted_address
    attr_accessor :location
    attr_accessor :address_components

    def initialize(place)
        place = place.symbolize_keys

        @id = place[:_id].to_s
        geometry = place[:geometry].symbolize_keys
        @location = Point.new(geometry[:geolocation])

        @address_components = place[:address_components].reduce([]){|memo,chunk| memo<< AddressComponent.new(chunk)}
        
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

    def self.find_by_short_name(short_name)
        collection.find({"address_components" => {:$elemMatch=>{"short_name"=>short_name}}})
    end

    def self.to_places(view)
        view.reduce([]) {|memo, place| memo<<Place.new(place)}
    end

    def self.find(id)
        place = collection.find({:_id=>BSON::ObjectId.from_string(id)}).first
        unless place.nil?
            Place.new(place)
        end
    end

    def self.all(offset=0, limit=0)
        to_places(
            collection.find.skip(offset).limit(limit)
        )
    end

    def destroy
        self.class.collection.find_one_and_delete({
            :_id=>BSON::ObjectId.from_string(@id)
        })
    end
end