require "pry"

class MusicLibraryController
    def initialize(path = "./db/mp3s")
        importer = MusicImporter.new(path)
        importer.import
    end

    def call
        puts "Welcome to your music library!"
        puts "To list all of your songs, enter 'list songs'."
        puts "To list all of the artists in your library, enter 'list artists'."
        puts "To list all of the genres in your library, enter 'list genres'."
        puts "To list all of the songs by a particular artist, enter 'list artist'."
        puts "To list all of the songs of a particular genre, enter 'list genre'."
        puts "To play a song, enter 'play song'."
        puts "To quit, type 'exit'."
        puts "What would you like to do?"

        loop do 
            input = gets.strip

            if (input == "list songs")
                list_songs
            elsif (input == "list artists")
                list_artists
            elsif (input == "list genres")
                list_genres
            elsif (input == "list artist")
                list_songs_by_artist
            elsif (input == "list genre")
                list_songs_by_genre
            elsif (input == "play song")
                play_song
            end

            break if input == "exit"
        end
    end

    def list_songs
        songs = get_song_list.map{|song| "#{song.artist.name} - #{song.name} - #{song.genre.name}"}
        print_list(songs)
    end

    def list_artists
        artists = Artist.all.sort { |artist1, artist2| artist1.name <=> artist2.name}
            .map{|artist| artist.name}
        print_list(artists)
    end

    def list_genres
        genres = Genre.all.sort { |genre1, genre2| genre1.name <=> genre2.name}
            .map{|genre| genre.name}
        print_list(genres)
    end    

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        artist_name = gets.strip
        artist = Artist.find_by_name(artist_name)
        if (artist != nil)           
            songs = artist.songs.sort { |song1, song2| song1.name <=> song2.name}
                .map{|song| "#{song.name} - #{song.genre.name}"}
            print_list(songs)
        end
    end 

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        genre_name = gets.strip
        genre = Genre.find_by_name(genre_name)
        if (genre != nil)           
            songs = genre.songs.sort { |song1, song2| song1.name <=> song2.name}
                .map{|song| "#{song.artist.name} - #{song.name}"}
            print_list(songs)
        end
    end 

    def play_song
        puts "Which song number would you like to play?"
        song_number = gets.strip.to_i
        song_list = get_song_list
        if song_number >= 1 && song_number <= get_song_list.count
            song = song_list[song_number-1]
            puts "Playing #{song.name} by #{song.artist.name}"
        end
    end

    private
    def print_list(list)
        index = 1
        list.each do |item|
            puts "#{index}. #{item}"
            index += 1
        end
    end

    def get_song_list
        Song.all.sort { |song1, song2| song1.name <=> song2.name}
    end
end