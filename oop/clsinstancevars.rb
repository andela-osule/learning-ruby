class Foo
    @foo_count = 0

    def self.increment_counter
        @foo_count += 1
    end

    def self.current_count
        @foo_count
    end
end


class Bar < Foo
    @foo_count = 100
end

Foo.increment_counter
Bar.increment_counter

p Foo.current_count
p Bar.current_count
