class Item
    attr_reader :item_name

    def initialize(item_name)
        @item_name = item_name
    end
end

item = Item.new("bangkok")

p item.item_name
