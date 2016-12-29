class Point
  attr_accessor :longitude
  attr_accessor :latitude

  def initialize(params)
    @longitude, @latitude = *params[:coordinates]
  end
  
  def self.mongoize(point)
    case point
      when nil then
        nil
      when Hash then
        point
      when Point then
        {:coordinates=>[point.longitude, point.latitude], :type=>"Point" }
    end
  end

  def self.demongoize(point)
    case point
      when nil then
        nil
      when Hash then
        new(point)
      when Point then
        point
    end
  end

  def self.evolve(point)
    point.mongoize
  end

  def mongoize
    self.class.mongoize(self)
  end
end