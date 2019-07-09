class MusicImporter
  attr_accessor :path, :files
  
  def initialize(path)
    @path = path
  end
  
  def files
		files = Dir.glob("#{path}**/*")
		files = files.collect{|file|file.scan(/(?<=mp3s\/)(.*)/)}.flatten 
	end

  def import
    files.each {|file| Song.create_from_filename(file) }
  end
end