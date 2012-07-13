require 'test_helpers'
 class PlaylistsShowSpec < MiniTest::Spec
  it "performs request" do
    TestApi.get "/playlists/:id", {}
    assert_api_response
  end
end
