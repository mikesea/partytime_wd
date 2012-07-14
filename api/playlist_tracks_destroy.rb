describe_service "playlists/:playlist_id/tracks/:id" do |service|
  service.formats   :json
  service.http_verb :delete
  service.disable_auth # on by default
  
  # INPUT
  service.params do |p|
    p.integer :playlist_id
    p.integer :id
  end
  
  # OUTPUT
  service.response do |response|
    response.object do |track|
      track.string :title
      track.string :album_title
      track.string :artist_name
      track.string :rdio_id
    end
  end
  
  # DOCUMENTATION
  service.documentation do |doc|
    doc.overall "This service removes a track from an existing playlist."
  end
  
  # ACTION/IMPLEMENTATION
  service.implementation do
    track = Track.where(id: params[:id]).first
    if track.playlist.id == params[:playlist_id]
      track.destroy.to_json
    else
      status 400
    end
  end
end
