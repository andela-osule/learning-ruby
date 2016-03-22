require 'open-uri'
require 'timeout'

remote_base_url = "https://en.wikipedia.org/wiki"

start_year = 1900
end_year = 2000

(start_year..end_year).each do |yr|
    begin
        rpage = open("#{remote_base_url}/#{yr}")
    rescue StandardError=>e
        puts "Error: #{e}"
    else
        rdata = rpage.read
    ensure
        puts "sleeping..."
        sleep 5
    end

    if rdata
        File.open("copy-of-#{yr}.html", "w"){|f| f.write(rdata)}
    end
end
