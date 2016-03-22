class Item
    class << self
        def show
            puts "Class method show invoked"
        end
    end

    def self.display
        puts "Class method display invoked"
    end
end


p Item.show
p Item.display
