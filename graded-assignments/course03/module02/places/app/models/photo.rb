class Photo
  attr_accessor :id
  attr_accessor :location
  attr_writer :contents

  def self.mongo_client
    Mongoid::Clients.default
  end

  def initialize(params={})
    @id = params[:_id].to_s unless params.nil? || params[:_id].nil?
    @location = Point.new(params[:metadata][:location]) unless params.nil? || params[:metadata].nil?
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
          :location=>@location.to_hash
        }
      }
      grid_file = Mongo::Grid::File.new(@contents.read, description)
      unless @contents.nil?
        id = self.class.mongo_client.database.fs.insert_one(grid_file)
        @id = id.to_s
      end
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
end
