class ApplicationConfiguration
    def self.set(property_name, value)
        @@property_name = value
    end

    def self.get(property_name)
        @@property_name
    end
end

ApplicationConfiguration.set("name", "Demo Application")
ApplicationConfiguration.set("version", "0.1")

p ApplicationConfiguration.get("version")
