class Entrant
  include Mongoid::Document
  field :_id, type: Integer
  field :name, type: String
  field :group, type: String
  field :secs, type: Float

  belongs_to :racer, validate: true
  embedded_in :contest

  before_create do |doc|
    racer = doc.racer
    if racer
      doc.name = "#{racer.last_name}, #{racer.first_name}"
    end
  end
end
