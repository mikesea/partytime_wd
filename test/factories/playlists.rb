FactoryGirl.define do
  factory :playlist, aliases: [:empty_playlist]

  factory :playlist_with_tracks, parent: :playlist do
    after(:create) do |playlist, evaluator|
      15.times do
        track = FactoryGirl.build(:track)
        playlist.tracks << track
      end
      playlist.save
    end
  end
end