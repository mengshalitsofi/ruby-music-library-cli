class Artist
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
        Artist.new(name)
    end

    def add_song(song)
        if song.artist == nil && !@songs.include?(song)
            @songs << song
            song.artist = self
        end
    end

    def genres        
        @songs.collect{|song| song.genre}.uniq
    end
end 