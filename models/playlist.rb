class Playlist < ActiveRecord::Base
  has_many :tracks

  def as_json
    { id: id, tracks: tracks.map(&:as_json) }
  end
end