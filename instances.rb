# Instance variables
class Item
    def initialize(item_name, quantity)
        @item_name = item_name
        @quantity = quantity
    end

    def show
        puts @item_name
        puts @quantity
    end
end

Item.new("tv", 1).show
Item.new("fridge", 1).show
