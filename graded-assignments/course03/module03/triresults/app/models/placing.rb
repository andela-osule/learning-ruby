class Placing
  attr_accessor :name
  attr_accessor :place

  def initialize(params)
    @name = params[:name]
    @place = params[:place]
  end

  def self.mongoize(placing)
    case placing
      when nil then
        nil
      when Hash then
        placing
      when Placing then
        {:name=>placing.name, :place=>placing.place}
    end
  end

  def self.demongoize(placing)
    case placing
      when nil then
        nil
      when Hash then
        new(placing)
      when Placing then
        placing
    end
  end

  def self.evolve(placing)
    placing.mongoize
  end

  def mongoize
    self.class.mongoize(self)
  end
end