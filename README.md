# Weasel Diesel Party Time!

This project is an (example) implementation of the [Party Time](https://github.com/mikesea/party_time) API using @mattetti's [Weasel Diesel](https://github.com/mattetti/Weasel-Diesel) web service DSL, and the [Weasel Diesel Sinatra](https://github.com/mattetti/wd-sinatra) gem.

## Usage
1. First, clone the repo and bundle the app's dependencies:
```
$ git clone git://github.com/mikesea/partytime_wd.git
$ cd partytime_wd
$ bundle install
```

2. Then, migrate the database (this will create a <code>development.sqlite3</code> database in the <code>db/</code> directory:
```
$ rake db:migrate RACK_ENV=development
```

3. Now, start the server!
```
$ bundle exec rackup
```

4. Or, boot up the console instead:
```
$ bundle exec bin/console
```

### Endpoints
Available endpoints are limited to:
```
POST /playlists
GET /playlists/:id
POST /playlists/:playlist_id/tracks
DELETE /playlists/:playlist_id/tracks/:id
```

### Documentation
Documentation for the API is found under the <code>doc/</code> directory. Open <code>doc/index.html</code> in your browser to navigate the docs. These docs are generated automatically by Weasel Diesel, so feel free to remove that directory and generate the documentation again with the following rake task:
```
rake doc:services
```

### Tests
To run the test, migrate the test database:
```
$ rake db:migrate RACK_ENV=test
```
Then, run the specs!
```
$ rake test
```