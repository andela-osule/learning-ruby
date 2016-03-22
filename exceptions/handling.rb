begin
    # somecode
    x = 7 / 0
rescue
    # handle_error
    # @error_message = "#{$!}"
    puts "#{$!}"
ensure
    # this code is always executed
    puts "Dividing by zero;"
end

