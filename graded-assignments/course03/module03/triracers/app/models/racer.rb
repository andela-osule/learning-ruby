class Racer
  include Mongoid::Document
  field :first_name, type: String, as: :fn
  field :last_name, type: String, as: :ln
  field :date_of_birth, type: Date, as: :dob
  field :gender, type: String
  store_in collection: 'racer1'
end
