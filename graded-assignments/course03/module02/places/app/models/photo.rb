class Photo
  attr_accessor :id
  attr_accessor :location
  attr_writer :contents

  def self.mongo_client
    Mongoid::Clients.default
  end

  def initialize(params=nil)
    @id = params[:_id].to_s unless params.nil?
    metadata = params[:metadata] unless params.nil?
    @location = Point.new(metadata[:location]) unless metadata.nil?
  end

  def persisted?
    return @id.nil? ? false : true
  end

  def save
    unless persisted?
      gps = EXIFR::JPEG.new(@contents).gps
      @location=Point.new({:lng=>gps.longitude, :lat=>gps.latitude})

      description = {
        :content_type=>"image/jpeg",
        :metadata=>{
          :location=>@location.to_hash
        }
      }
      grid_file = Mongo::Grid::File.new(@contents.read, description)
      @id = self.class.mongo_client.database.fs.insert_one(grid_file).to_s
    end
  end

  def self.all(offset=0, limit=0)
    mongo_client.database.fs.find.skip(offset).limit(limit).map{|doc| Photo.new(doc)}
  end

  def self.find(id)
    doc = mongo_client.database.fs.find(:_id=>BSON::ObjectId.from_string(id)).first
    Photo.new(doc)
  end
end