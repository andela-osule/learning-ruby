class Planet
    @@planet_count = 0

    def initialize(name)
        @name = name
        @@planet_count += 1
    end

    def self.planet_count
        @@planet_count
    end
end


Planet.new('Earth'); Planet.new('Uranus')

p Planet.planets_count
