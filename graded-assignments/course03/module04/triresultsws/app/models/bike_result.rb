class BikeResult < LegResult
  field :mph, type: Float

  def calc_ave
    if event && secs
      miles = event.miles
      self[:mph] = miles*3600/secs unless miles.nil?
    end
  end
end
