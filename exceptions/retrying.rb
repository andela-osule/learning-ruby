for i in 'A'..'C'
    retries = 2
    begin
        puts "Executing command #{i}"
        raise "Exception: #{i}"
    rescue Exception=>e
        puts "t\Caught: #{e}"
        if retries > 0
            puts "t\Trying #{retries} more times\n"
            retries -= 1
            sleep 2
            retry
        end
    end
end
