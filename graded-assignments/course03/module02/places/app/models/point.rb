class Point
    attr_accessor :longitude
    attr_accessor :latitude

    def initialize(point)
        @longitude = point[:lng] unless point[:lng].nil?
        @latitude = point[:lat] unless point[:lat].nil?
        @longitude, @latitude = point[:coordinates] unless point[:coordinates].nil?
    end


    def to_hash
        return {
            :type=>"Point", 
            :coordinates=>[@longitude, @latitude]
        }
    end

end