class Address
  attr_accessor :city
  attr_accessor :state
  attr_accessor :location

  def initialize(params)
    @city = params[:city]
    @state = params[:state]
    @location = Point.new(params[:loc])
  end

  def self.mongoize(address)
    case address
    when nil then
      nil
    when Hash then
      address
    when Address then
      {:city=>address.city, :state=>address.state, :loc=>address.location.mongoize }
    end
  end

  def self.demongoize(address)
    case address
      when nil then
        nil
      when Hash then
        new(address)
      when Address then
        address
    end
  end

  def self.evolve(address)
    address.mongoize
  end

  def mongoize
    self.class.mongoize(self)
  end
end