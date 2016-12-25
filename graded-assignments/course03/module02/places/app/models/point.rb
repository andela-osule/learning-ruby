class Point
    attr_accessor :longitude
    attr_accessor :latitude

    def initialize(point)
        @longitude = point[:lng] if point.key? :lng
        @latitude = point[:lat] if point.key? :lat
        @longitude, @latitude = point[:coordinates] if point.key? :coordinates
    end


    def to_hash
        return {
            :type=>"Point", 
            :coordinates=>[@longitude, @latitude]
        }
    end

end