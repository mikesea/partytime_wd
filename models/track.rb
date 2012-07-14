class Track < ActiveRecord::Base
  belongs_to :playlist

  def as_json(*options)
    { 
      id: id,
      title: title,
      album_title: album_title,
      artist_name: artist_name,
      rdio_id: rdio_id }
  end
end