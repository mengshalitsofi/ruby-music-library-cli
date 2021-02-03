class Song
    extend Concerns::Findable
    extend Persistable::ClassMethods
    include Persistable::InstanceMethods

    attr_accessor :name
    attr_reader :artist, :genre

    @@all = []

    def initialize(name, artist = nil, genre = nil)
        @name = name
        self.artist = artist
        self.genre = genre
    end

    def self.all
        @@all
    end

    def self.create(name)
        song = Song.new(name)
        song.save
        song
    end

    def artist=(artist)
        artist.add_song(self) unless artist == nil
        @artist = artist
    end

    def genre=(genre)
        genre.add_song(self) unless genre == nil
        @genre = genre
    end

    def self.new_from_filename(filename)
        parts = filename.split(" - ")
        song_name = parts[1]
        artist_name = parts[0]
        genre_name = parts[2].split(".")[0]
        
        song = find_or_create_by_name(song_name)
        artist = Artist.find_or_create_by_name(artist_name)
        genre = Genre.find_or_create_by_name(genre_name)

        song.artist = artist
        song.genre = genre
        song
    end

    def self.create_from_filename(filename)
        song = new_from_filename(filename)
    end
end