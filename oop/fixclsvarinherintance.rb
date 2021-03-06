class ApplicationConfiguration
    @configuration = {}

    def self.set(property_name, value)
        @configuration[property_name] = value
    end

    def self.get(property_name)
        @configuration[property_name]
    end
end


class ERPApplicationConfiguration < ApplicationConfiguration
    @configuration = {}
end

class WebApplicationConfiguration < ApplicationConfiguration
    @configuration = {}
end


ERPApplicationConfiguration.set("name", "ERP Application")
WebApplicationConfiguration.set("name", "Web Application")

p ERPApplicationConfiguration.get("name")  # Web Application
p WebApplicationConfiguration.get("name")  # Web Application

p ApplicationConfiguration.get("name")  # Web Application

# All classes have the class instance variable @configuration initialize in each of them.
