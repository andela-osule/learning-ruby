class Point
  attr_accessor :longitude
  attr_accessor :latitude

  def initialize(
    longitude,
    latitude
  )
    @longitude=longitude
    @latitude=latitude
  end

  def mongoize
    {:type=>"Point", :coordinates=>[@longitude, @latitude]}
  end

  def self.demongoize(params)
    new(*params[:coordinates])
  end

  def self.mongoize(point)
    return point.mongoize if point.is_a? Point
    return point
  end

  def self.evolve(point)
    point.mongoize
  end
end