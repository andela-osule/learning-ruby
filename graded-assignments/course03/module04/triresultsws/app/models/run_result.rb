class RunResult < LegResult
  field :mmile, type: Float, as: :minute_mile

  def calc_ave
    if event && secs
      miles = event.miles
      self[:mmile] = (secs/60)/miles unless miles.nil?
    end
  end
end
