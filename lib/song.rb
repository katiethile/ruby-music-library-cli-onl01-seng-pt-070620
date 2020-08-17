require 'pry'

class Song 
  attr_accessor :name, :artist, :genre, :musicimporter, :musiclibrarycontroller 
  
  @@all = []
  
  def initialize(name, artist = nil, genre = nil)
    @name = name 
    self.artist = artist if artist 
    self.genre = genre if genre 
  end 
  
  def self.all 
    @@all 
  end 
  
  def self.destroy_all 
    @@all.clear 
  end 
  
  def save 
    @@all << self 
  end 
  
  def self.create(song)
    song = self.new(song)
    song.save
    song 
  end 
  
  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end 
  
   def genre=(genre)
    @genre = genre
    if !(genre.songs.include?(self))
    genre.songs << self 
   end 
  end 
  
   def self.find_by_name(name)
     @@all.detect {|song|song.name == name}
   end 
  
  def self.find_or_create_by_name(name)
    self.find_by_name(name) || self.create(name)
  end 
  
  def self.new_from_filename(name)
    artist, song, genre_name = name.split(" - ")
    new_genre = genre_name.gsub('.mp3', '')
    artist = Artist.find_or_create_by_name(artist)
    genre = Genre.find_or_create_by_name(new_genre)
    new(song, artist, genre)
    end 
    
  def self.create_from_filename(name)
      new_from_filename(name).save
  end 
 end 