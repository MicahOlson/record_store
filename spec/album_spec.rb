require 'rspec'
require 'pry'
require 'album'
require 'song'

describe '#Album' do
  after(:each) do
    Album.clear
    Song.clear
  end

  describe('.all') do
    it("returns an empty array when there are no albums") do
      expect(Album.all).to(eq([]))
    end
  end

  describe('#==') do
    it("is the same album if it has the same name and artist as another album") do
      album = Album.new({name: "Moon Safari", artist: "Air"})
      album2 = Album.new({name: "Moon Safari", artist: "Air"})
      expect(album).to(eq(album2))
    end
  end
  
  describe('#save') do
    it("saves an album") do
      album = Album.new({name: "Moon Safari"})
      album.save
      album2 = Album.new({name: "Talkie Walkie"})
      album2.save
      expect(Album.all).to(eq([album, album2]))
    end
  end
  
  describe('.clear') do
    it("clears all albums") do
      album = Album.new({name: "Moon Safari"})
      album.save
      album2 = Album.new({name: "Talkie Walkie"})
      album2.save
      Album.clear
      expect(Album.all).to(eq([]))
    end
  end

  describe('.find') do
    it("finds an album by id") do
      album = Album.new({name: "Moon Safari"})
      album.save
      album2 = Album.new({name: "Talkie Walkie"})
      album2.save
      expect(Album.find(album.id)).to(eq(album))
    end
  end

  describe('#update') do
    it("updates given attributes of an album by id") do
      album = Album.new({name: "Moo Safar", artist:"Air", year: "1998", genre: "unknown"})
      album.save
      album.update({name: "Moon Safari", genre: "Electronica"})
      expect("#{album.name}, #{album.artist}, #{album.year}, #{album.genre}").to(eq("Moon Safari, Air, 1998, Electronica"))
    end
  end

  describe('#delete') do
    it("deletes an album by id") do
      album = Album.new({name: "Moon Safari"})
      album.save
      album2 = Album.new({name: "Talkie Walkie"})
      album2.save
      album.delete
      expect(Album.all).to(eq([album2]))
    end
  end

  describe('.search') do
    it('finds an album by name regardless of case') do
      album = Album.new({name: "Moon Safari"})
      album.save
      album2 = Album.new({name: "Talkie Walkie"})
      album2.save
      expect(Album.search("moon safari")).to(eq([album]))
    end
  end

  describe('#songs') do
    it("returns an album's songs") do
      album = Album.new({name: "Moon Safari"})
      album.save
      song = Song.new({name: "La femme d'argent", album_id: album.id})
      song.save
      song2 = Song.new({name: "Sexy Boy", album_id: album.id})
      song2.save
      expect(album.songs).to(eq([song, song2]))
    end
  end
end
