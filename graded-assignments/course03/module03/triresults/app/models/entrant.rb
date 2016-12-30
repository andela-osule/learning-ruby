class Entrant
  include Mongoid::Document
  include Mongoid::Timestamps

  field :bib, type: Integer
  field :secs, type: Float
  field :o, type: Placing, as: :overall
  field :gender, type: Placing
  field :group, type: Placing

  store_in collection: 'results'

  embeds_many :results, class_name: 'LegResult', order: [:"event.o".asc], after_add: :update_total
  embeds_one :race, class_name: "RaceRef"
  embeds_one :racer, as: :parent, class_name: 'RacerInfo'


  def update_total(result) 
    self[:secs] = results.reduce(0.0) {|memo, chunk| memo + chunk.secs}
  end

  def the_race
    race.race
  end
end
