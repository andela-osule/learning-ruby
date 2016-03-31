puts "Holy giraffes! You fell into a maze!"
print "Where to? (N, E, S, W, NW, NE, SW, SE, up, down): "
direction = gets.chomp.upcase

puts "#{direction}, you say? A fine choice!"

if direction == "N" || direction == "UP"
    puts "You are in a maze of twisty little passages, all alike."
elsif direction == "E"
    puts "An elf! And his pet ham!"
elsif direction == "S" || direction == "DOWN"
    puts "A minotaur! Wait, no, that's just your reflection."
elsif direction == "W"
    puts "You're here, wherever here is."
elsif direction == "NW"
    puts "Oh, a gorilla in a cage!"
elsif direction == "SW"
    puts "There a subway station."
elsif direction == "NE"
    puts "Gracious me! It a pantomime cat."
elsif direction == "SE"
    puts "Ssh...the baby is sleeping."
else
    puts "Wait, is that even a direction?"
end
