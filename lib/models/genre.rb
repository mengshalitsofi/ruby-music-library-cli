class Genre
    extend Concerns::Findable
    extend Persistable::ClassMethods
    include Persistable::InstanceMethods

    attr_accessor :name
    attr_reader :songs

    @@all = []

    def initialize(name)
        @name = name
        @songs = []
        save
    end

    def self.all
        @@all
    end

    def self.create(name)
        Genre.new(name)
    end

    def add_song(song)
        if song.genre == nil && !@songs.include?(song)
            @songs << song
            song.genre = self
        end
    end

    def artists
        @songs.collect{|song| song.artist}.uniq
    end
end