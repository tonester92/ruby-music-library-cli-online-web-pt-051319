class Song
  extend Concerns::Findable
  attr_accessor :name, :artist, :genre

  @@all = []

  def initialize(name, artist= nil, genre= nil)
    @name = name
    self.artist= (artist) unless artist == nil
    self.genre= (genre) unless genre == nil
    save
  end

  def self.all
    @@all 
  end

  def self.destroy_all
    self.all.clear
  end

  def save
    @@all << self
  end
  
  def self.create(song, artist=nil, genre=nil)
    new_song = Song.new(song, artist, genre)
  end
  
  def artist=(artist)
    @artist = artist
    self.artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    self.genre.add_song(self)
  end

  def self.find_by_name(name)
    all.find {|song| song.name == name}
  end

  def self.find_or_create_by_name(name)
    find_by_name(name) || create(name)
  end

  def self.new_from_filename(filename)
    info = filename.split(" - ")
    artist, name, genre = info[0], info[1], info[2].gsub( ".mp3" , "")
    genre = Genre.find_or_create_by_name(genre)
    artist = Artist.find_or_create_by_name(artist)
    new(name,artist,genre)
  end

  def self.find_or_create_by_name(song_name)
    song = self.find_by_name(song_name)
    if song == nil
      self.create(song_name)
    else
      song
    end
  end
end