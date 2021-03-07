require 'rspec'
require 'pry'
require 'song'
require 'album'

describe '#Song' do
  before(:each) do
    @album = Album.new({name: "Moon Safari"})
    @album.save
  end

  after(:each) do
    Album.clear
    Song.clear
  end

  describe('#==') do
    it('is the same song if it has the same name and album id as another song') do
      song = Song.new({name: "La femme d'argent", album_id: @album.id})
      song2 = Song.new({name: "La femme d'argent", album_id: @album.id})
      expect(song).to(eq(song2))
    end
  end

  describe('#save') do
    it("saves a song") do
      song = Song.new({name: "La femme d'argent", album_id: @album.id})
      song.save
      expect(Song.all).to(eq([song]))
    end
  end

  describe('.all') do
    it("returns a list of all songs") do
      song = Song.new({name: "La femme d'argent", album_id: @album.id})
      song.save
      song2 = Song.new({name: "Sexy Boy", album_id: @album.id})
      song2.save
      expect(Song.all).to(eq([song, song2]))
    end
  end

  describe('.clear') do
    it("clears all songs") do
      song = Song.new({name: "La femme d'argent", album_id: @album.id})
      song.save
      song2 = Song.new({name: "Sexy Boy", album_id: @album.id})
      song2.save
      Song.clear
      expect(Song.all).to(eq([]))
    end
  end

  describe('.find') do
    it("finds a song by id") do
      song = Song.new({name: "La femme d'argent", album_id: @album.id})
      song.save
      song2 = Song.new({name: "Sexy Boy", album_id: @album.id})
      song2.save
      expect(Song.find(song.id)).to(eq(song))
    end
  end

  describe('#update') do
    it("updates a song by id") do
      song = Song.new({name: "LaFem d'Argent", album_id: @album.id})
      song.save
      song.update({name: "La femme d'argent", album_id: @album.id})
      expect(song.name).to(eq("La femme d'argent"))
    end
  end

  describe('#delete') do
    it('deletes a song by id') do
      song = Song.new({name: "La femme d'argent", album_id: @album.id})
      song.save
      song2 = Song.new({name: "Sexy Boy", album_id: @album.id})
      song2.save
      song.delete
      expect(Song.all).to(eq([song2]))
    end
  end

  describe('.find_by_album') do
    it('finds songs for an album') do
      album2 = Album.new({name: "Talkie Walkie"})
      album2.save
      song = Song.new({name: "La femme d'argent", album_id: @album.id})
      song.save
      song2 = Song.new({name: "Venus", album_id: album2.id})
      song2.save
      expect(Song.find_by_album(album2.id)).to(eq([song2]))
    end
  end

  describe('#album') do
    it("finds the album a song belongs to") do
      song = Song.new({name: "La femme d'argent", album_id: @album.id})
      song.save
      expect(song.album()).to(eq(@album))
    end
  end
end
