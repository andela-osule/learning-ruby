# give 3 different output based on whether left operand is greater, less or
# equal to the right side.

puts 1 <=> 1 # 0
puts 1 <=> 100 # -1
puts 1 <=> -100 # 1

def Person
    def <=> (other_person)
        self.last_name <=> other_person.last_name
    end
end
