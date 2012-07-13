FactoryGirl.define do
  factory :track do
    sequence(:album_title) { |n| "album_#{n}" }
    sequence(:artist_name) { |n| "artist_#{n}" }
    sequence(:title) { |n| "title_#{n}" }
    sequence(:rdio_id) { |n| "#{n}" }
  end
end