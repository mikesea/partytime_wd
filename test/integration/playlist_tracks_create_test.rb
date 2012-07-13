require 'test_helpers'

class PlaylistTracksCreateSpec < MiniTest::Spec
  before :each do
    DatabaseCleaner.start
  end

  after :each do
    DatabaseCleaner.clean
  end

  let(:playlist) { FactoryGirl.create(:playlist_with_tracks) }
  let(:track) { { title: "a song", album_title: "an album", artist_name: "an artist", rdio_id: "t1234" } }

  it "performs request" do
    TestApi.post "/playlists/:playlist_id/tracks", { playlist_id: playlist.id, track: track }
    assert_api_response
  end
end
