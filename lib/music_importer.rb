class MusicImporter
    attr_reader :path

    def initialize(path)
        @path = path
    end

    def files        
        Dir.children(@path).select{|file| file.end_with?(".mp3")}
    end
    
    def import
        songs = []
        files.each do |file|
            songs << Song.create_from_filename(file)
        end
        songs
    end
end