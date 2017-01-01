class LegResult
  include Mongoid::Document
  field :secs, type: Float

  embedded_in :entrant
  embeds_one :event, as: :parent

  validates_presence_of :event

  after_initialize do |leg_result|
    leg_result.calc_ave
  end

  def calc_ave
  end

  def secs=value
    self[:secs] = value
    calc_ave
  end
end
