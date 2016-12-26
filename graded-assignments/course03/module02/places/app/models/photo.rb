class Photo
  attr_accessor :id
  attr_accessor :location
  attr_accessor :place
  attr_writer :contents

  def self.mongo_client
    Mongoid::Clients.default
  end

  def initialize(params={})
    @id = params[:_id].to_s unless params.nil? || params[:_id].nil?
    @location = Point.new(params[:metadata][:location]) unless params.nil? || params[:metadata].nil?
    @place = params[:metadata][:place] unless params.nil? || params[:metadata].nil?
  end

  def persisted?
    return !@id.nil?
  end

  def save
    unless persisted?
      gps = EXIFR::JPEG.new(@contents).gps
      @location=Point.new({:lng=>gps.longitude, :lat=>gps.latitude})
      description = {
        :content_type=>"image/jpeg",
        :metadata=>{
          :location=>@location.to_hash,
          :place=>@place
        }
      }
      grid_file = Mongo::Grid::File.new(@contents.read, description)
      @id = self.class.mongo_client.database.fs.insert_one(grid_file).to_s unless @contents.nil?
    else
      doc = self.class.mongo_client.database.fs.find(:_id=>BSON::ObjectId.from_string(@id)).first
      doc[:metadata] = {:location=>@location.to_hash, :place=>@place}
      self.class.mongo_client.database.fs.find(
        '_id': BSON::ObjectId.from_string(@id)
      ).update_one(doc)
    end
  end

  def self.all(offset=0, limit=0)
    mongo_client.database.fs.find.skip(offset).limit(limit).map{|doc| Photo.new(doc)}
  end

  def self.find(id)
    doc = mongo_client.database.fs.find(:_id=>BSON::ObjectId.from_string(id)).first
    Photo.new(doc) unless doc.nil?
  end

  def contents
    gf = self.class.mongo_client.database.fs.find_one(:_id=>BSON::ObjectId.from_string(@id))

    gf.nil? ? "" : Mongo::Grid::File::Chunk.assemble(gf.chunks)
  end

  def destroy
    self.class.mongo_client.database.fs.find(:_id=>BSON::ObjectId.from_string(@id)).delete_one
  end

  def find_nearest_place_id(max_dist)
    place_id = Place.near(@location, max_dist).limit(1).projection(:_id=>1).first
    place_id[:_id] || 0
  end

  def place
    unless @place.nil?
      Place.find(@place.to_s)
    end
  end

  def place=(_place)
    @place = BSON::ObjectId.from_string(_place.id) if _place.is_a? Place
    @place = BSON::ObjectId.from_string(_place) if _place.is_a? String
    @place = _place if BSON::ObjectId
  end
end
