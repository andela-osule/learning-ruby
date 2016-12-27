class Place
    include ActiveModel::Model
    attr_accessor :id
    attr_accessor :formatted_address
    attr_accessor :location
    attr_accessor :address_components

    def initialize(place)
        @id = place[:_id].to_s
        @location = Point.new(place[:geometry][:geolocation])
        @address_components = !place[:address_components].nil? ? place[:address_components].reduce([]){|memo,chunk| memo<<AddressComponent.new(chunk)} : []
        @formatted_address = place[:formatted_address]     
    end

    def persisted?
        !@id.nil?
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

    def self.get_address_components(sort=nil, offset=nil, limit=nil)
        aggregation = collection.find.aggregate([
            {:$unwind=>"$address_components"},
            {:$project=>{:_id=>1, :address_components=>1, :formatted_address=>1, :geometry=>{:geolocation=>1}}}
        ])
        aggregation.pipeline << {:$sort=>sort} unless sort.nil?
        aggregation.pipeline << {:$skip=>offset} unless offset.nil?
        aggregation.pipeline << {:$limit=>limit} unless offset.nil? 
        return aggregation
    end

    def self.get_country_names
        collection.find.aggregate([
            {:$unwind=>"$address_components"},
            {:$project=>{:_id=>1, :address_components=>{:types=>1, :long_name=>1}}},
            {:$match=>{"address_components.types"=>{:$eq=>"country"}}},
            {:$group=>{:_id=>"$address_components.long_name"}}
        ]).to_a.map {|h| h[:_id]}
    end

    def self.find_ids_by_country_code(country_code)
        collection.find.aggregate([
            {:$unwind=>"$address_components"},
            {:$match=>{"address_components.short_name"=>{:$eq=>country_code}}},
            {:$project=>{:_id=>1}}
        ]).map {|doc| doc[:_id].to_s}
    end

    def self.create_indexes
        collection.indexes.create_one({"geometry.geolocation"=>Mongo::Index::GEO2DSPHERE})
    end

    def self.remove_indexes
        collection.indexes.drop_one("geometry.geolocation_2dsphere")
    end

    def self.near(point, max_dist=nil)
        near = {
            :$near=>{
                :$geometry=>point.to_hash,
            }
        }
        near[:$near][:$maxDistance] = max_dist.to_i unless max_dist.nil?

        collection.find({"geometry.geolocation"=>near})
    end

    def near(max_dist=nil)
        self.class.to_places(
            self.class.near(@location, max_dist)
        )
    end

    def photos(offset=0, limit=0)
        self.class.mongo_client.database.fs.find(
            "metadata.place"=>BSON::ObjectId.from_string(@id)
        )
        .skip(offset)
        .limit(limit)
        .map{|photo| Photo.new(photo)}
    end
end