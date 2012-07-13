class CreateTracksTable < ActiveRecord::Migration
  def self.up
    create_table :tracks do |t|
      t.string :artist_name
      t.string :album_title
      t.string :title
      t.string :rdio_id
      t.timestamps
    end
  end

  def self.down
  end
end
