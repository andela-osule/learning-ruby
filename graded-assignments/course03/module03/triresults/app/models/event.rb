class Event
  include Mongoid::Document
  field :o, type: Integer, as: :order
  field :n, type: String, as: :name
  field :d, type: Float, as: :distance
  field :u, type: String, as: :units

  embedded_in :parent, polymorphic: true, touch: true

  validates_presence_of :order
  validates_presence_of :name

  def meters
    case units
      when "miles" then
        distance * 1609.344
      when "kilometers" then
        distance * 1000
      when "yards" then
        distance * 0.9144
      when "meters" then
        distance
    end
  end

  def miles
    case units
      when "meters" then
        distance * 0.000621371
      when "kilometers" then
        distance * 0.621371
      when "yards" then
        distance * 0.000568182
      when "miles" then
        distance
    end
  end
end
