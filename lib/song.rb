class Song
  attr_reader :id
  attr_accessor :name, :album_id

  @@songs = {}
  @@total_rows = 0

  def initialize(attrs)
    @name = attrs[:name]
    @album_id = attrs[:album_id]
    @id = attrs[:id] || @@total_rows += 1
  end 

  def ==(song_to_compare)
    (self.name == song_to_compare.name) && (self.album_id == song_to_compare.album_id)
  end 

  def self.all
    @@songs.values
  end  

  def save
    @@songs[self.id] = Song.new({name: self.name, album_id: self.album_id, id: self.id})
  end

  def self.find(id)
    @@songs[id]
  end 

  def update(updates)
    self.name = updates[:name]
    self.album_id = updates[:album_id]
    @@songs[self.id] = Song.new({name: self.name, album_id: self.album_id, id: self.id})
  end 

  def delete
    @@songs.delete(self.id)
  end

  def self.clear
    @@songs = {}
  end 

  def self.find_by_album(alb_id)
    @@songs.values.select { |song| song.album_id == alb_id }
  end 

  def album
    Album.find(self.album_id)
  end
end
