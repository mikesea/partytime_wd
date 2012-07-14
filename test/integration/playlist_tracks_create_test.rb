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

  it "creates a new track" do
    tracks_count = playlist.tracks.count
    TestApi.post "/playlists/:playlist_id/tracks", { playlist_id: playlist.id, track: track }
    assert_equal playlist.tracks.count, tracks_count + 1
  end

  it "returns a 201 response code on successful creation" do
    TestApi.post "/playlists/:playlist_id/tracks", { playlist_id: playlist.id, track: track }
    assert_equal 201, TestApi.json_response.status
  end

  describe "bad requests" do
    before(:each) do
      TestApi.post "/playlists/:playlist_id/tracks", { playlist_id: playlist.id+1, track: track }
    end

    it "returns a 400 if the playlist doesn't exist" do
      assert_equal 400, TestApi.json_response.status
    end

  end
end
