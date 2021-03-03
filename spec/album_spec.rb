require 'rspec'
require 'album'
require 'pry'

describe '#Album' do

  before(:each) do
    Album.clear()
  end

  describe('.all') do
    it("returns an empty array when there are no albums") do
      expect(Album.all).to(eq([]))
    end
  end

  describe('#==') do
    it("is the same album if it has the same attributes as another album") do
      album = Album.new("Blue", "year", "artist", "genre", nil)
      album2 = Album.new("Blue", "year", "artist", "genre", nil)
      expect(album).to(eq(album2))
    end
  end
  
  describe('#save') do
    it("saves an album") do
      album = Album.new("Giant Steps", "", "", "", nil)
      album.save()
      album2 = Album.new("Blue", "", "", "", nil)
      album2.save()
      expect(Album.all).to(eq([album, album2]))
    end
  end
  
  describe('.clear') do
    it("clears all albums") do
      album = Album.new("Giant Steps", "", "", "", nil)
      album.save()
      album2 = Album.new("Blue", "", "", "", nil)
      album2.save()
      Album.clear()
      expect(Album.all).to(eq([]))
    end
  end

  describe('.find') do
    it("finds an album by id") do
      album = Album.new("Giant Steps", "", "", "", nil)
      album.save()
      album2 = Album.new("Blue", "", "", "", nil)
      album2.save()
      expect(Album.find(album.id)).to(eq(album))
    end
  end

  describe('#update') do
    it("updates an album by id") do
      album = Album.new("Giant Steps", "", "", "", nil)
      album.save()
      album.update("A Love Supreme", "New", "Updated", "Changed")
      expect(album.name).to(eq("A Love Supreme"))
      expect(album.year).to(eq("New"))
      expect(album.artist).to(eq("Updated"))
      expect(album.genre).to(eq("Changed"))
    end
  end

  describe('#update') do
  it("updates an album by id") do
    album = Album.new("Giant Steps", "old", "Old", "NotChanged", nil)
    album.save()
    album.update("A Love Supreme", "", "", "")
    expect(album.name).to(eq("A Love Supreme"))
    expect(album.year).to(eq("old"))
    expect(album.artist).to(eq("Old"))
    expect(album.genre).to(eq("NotChanged"))
  end
end

  describe('#delete') do
    it("deletes an album by id") do
      album = Album.new("Giant Steps", "", "", "", nil)
      album.save()
      album2 = Album.new("Blue", "", "", "", nil)
      album2.save()
      album.delete()
      expect(Album.all).to(eq([album2]))
    end
  end

  describe('.search') do
    it('finds an album by name') do
      album = Album.new("Giant Steps", "", "", "", nil)
      album.save()
      album2 = Album.new("Blue", "", "", "", nil)
      album2.save()
      expect(Album.search("Giant Steps")).to(eq([album]))
    end
    it('finds an album by name regardless of case sensitivity') do
      album = Album.new("Giant Steps", "", "", "", nil)
      album.save()
      album2 = Album.new("Blue", "", "", "", nil)
      album2.save()
      expect(Album.search("giant steps")).to(eq([album]))
    end
  end

end