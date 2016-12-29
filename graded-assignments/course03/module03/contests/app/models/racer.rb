class Racer
  include Mongoid::Document
  field :fn, as: :first_name, type: String
  field :ln, as: :last_name, type: String
  field :dob, as: :date_of_birth, type: Date

  embeds_one :primary_address, as: :addressable, class_name: 'Address'
  has_many :races, class_name: "Entrant"
end
