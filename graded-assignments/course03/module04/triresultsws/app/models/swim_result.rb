class SwimResult < LegResult
  field :pace_100, type: Float

  def calc_ave
    if event && secs
        meters = event.meters
        self.pace_100 = secs*100/meters unless meters.nil?
        # puts "Pace 100 is: ", self[:pace_100]
    end
  end
end
