class Album
  attr_reader :id, :length
  attr_accessor :name, :artist, :year, :genre
  
  @@albums = {}
  @@total_rows = 0

  def initialize(attrs)
    @name = attrs[:name]
    @artist = attrs[:artist]
    @year = attrs[:year]
    @genre = attrs[:genre]
    @length = attrs[:length]
    @id = attrs[:id] || @@total_rows += 1
  end

  def self.all
    @@albums.values
  end

  def save
    @@albums[self.id] = Album.new({name: self.name, artist: self.artist, year: self.year, genre: self.genre, length: self.length, id: self.id})
  end

  def ==(album_to_compare)
    (self.name == album_to_compare.name) && (self.artist == album_to_compare.artist)
  end

  def self.clear
    @@albums = {}
    @@total_rows = 0
  end

  def self.find(id)
    @@albums[id]
  end

  def update(updates)
    @name = updates[:name] || self.name
    @artist = updates[:artist] || self.artist
    @year = updates[:year] || self.year
    @genre = updates[:genre] || self.genre
  end

  def delete
    @@albums.delete(self.id)
  end

  def self.search(name)
    @@albums.values.select { |album| album.name.downcase == name.downcase }
  end 

  def songs
    Song.find_by_album(self.id)
  end
end
