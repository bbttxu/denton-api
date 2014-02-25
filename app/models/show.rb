#a show is an event with one or more artists which takes place at a venue
class Show
  include Mongoid::Document
  include Mongoid::Timestamps

  field :price, :type => String, :default => "?"
  field :source, :type => String
  field :doors_at, :type => Time
  field :starts_at, :type => Time
  field :time_is_uncertain, :type => Boolean

  belongs_to :venue
  has_many :gigs, dependent: :delete
  has_many :artists #, :through => :gigs

  scope :after, lambda { |date| where(:starts_at.gte => date.localtime ) }
  scope :before, lambda { |date| where(:starts_at.lte => date.localtime ) }
  scope :upcoming, lambda { where( :starts_at.gte => ( Time.zone.now - 6 * 60 * 60 ) ) }
  scope :ordered, order_by( :starts_at => :asc )

  validates_presence_of :price, :source, :starts_at, :time_is_uncertain

  def self.by_day()
    daily_events = {}
    self.upcoming.each do |event|
      date_str = event.starts_at.to_date.to_s
      daily_events[date_str] ||= 0
      daily_events[date_str] += 1
    end
    return daily_events
  end
end
