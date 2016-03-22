class Item
    # setters
    attr_writer :description

    # getters
    attr_reader :description

    # accessors = setter & getter
    attr_accessor :color


    def initialize(description, color)
        @description = description
        @color = color
    end

end

item = Item.new("Bag", "Brown")

item.description=("Shoes")

item.color = "Blue"

p item.description
p item.color
