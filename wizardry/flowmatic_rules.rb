flowmatic_on = true
water_available = true
if flowmatic_on && water_available
    flow_rate = 50
elsif !flowmatic_on
    puts "Flowmatic is off"
else
    puts "No water!"
end

# 1: Check flow rate
if flow_rate > 50
    puts "Warning! flow_rate is above 50! It's #{flow_rate}."
    flow_rate = 50
    puts "The flow_rate's been reset to #{flow_rate}."
elsif flow_rate < 50
    puts "Warning! flow_rate is below 50! It's #{flow_rate}."
    flow_rate = 50
    puts "The flow_rate's been reset to #{flow_rate}."
else
    puts "The flow_rate is #{flow_rate} (thank goodness)."
end

# 2: Refactor check flow rate
if flow_rate < 50 || flow_rate > 50
    puts "Warning! flow_rate is not 50! It's #{flow_rate}."
    flow_rate = 50
    puts "The flow_rate's been reset to #{flow_rate}."
else
    puts "The flow_rate is #{flow_rate} (thank goodness)."
end

# 3: Refactor check flow rate
if flow_rate != 50
    puts "Warning! flow_rate is not 50! It's #{flow_rate}."
end

# 4: Refactor check flow rate
unless flow_rate == 50
    puts "Warning! flow_rate is not 50! It's #{flow_rate}"
end



