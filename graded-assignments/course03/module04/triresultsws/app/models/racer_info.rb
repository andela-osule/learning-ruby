class RacerInfo
  include Mongoid::Document
  field :fn, type: String, as: :first_name
  field :ln, type: String, as: :last_name
  field :g, type: String, as: :gender
  field :yr, type: Integer, as: :birth_year
  field :res, type: Address, as: :residence
  field :racer_id, as: :_id
  field :_id, default:->{ racer_id }

  embedded_in :parent, polymorphic: true

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates :gender, presence: true, inclusion: {in: %w(M F)}
  validates :birth_year, presence: true, numericality: { less_than: Date.today.year }

  ["city", "state"].each do |action| 
    define_method("#{action}") do
      self.residence ? self.residence.send("#{action}") : nil 
    end
    
    define_method("#{action}=") do |name|
      object=self.residence ||= Address.new 
      object.send("#{action}=", name) 
      self.residence=object
    end
  end
end
