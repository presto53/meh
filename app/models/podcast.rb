class Podcast < ActiveRecord::Base
  belongs_to :stream

  validates_presence_of :name, :stream
  validates :length, numericality: { greater_than: 0 }

  scope :record_next, -> { where("day_of_week = ? OR day_of_week = ?", Time.now.wday, Time.now.tomorrow.wday) }

  def self.schedule_recording
    Episode.schedule_for_podcasts(Podcast.all)
  end
end
