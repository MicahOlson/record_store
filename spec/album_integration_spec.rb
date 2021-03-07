require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('create an album path', {:type => :feature}) do
  it('creates an album and then goes to the album page') do
    visit('/albums')
    click_on('Add a new album')
    fill_in('album_name', :with => "Moon Safari")
    click_on('Go!')
    expect(page).to have_content("Moon Safari")
  end
end

describe('create a song path', {:type => :feature}) do
  it('creates an album and then goes to the album page and creates a song') do
    album = Album.new({name: "Moon Safari"})
    album.save
    visit("/albums/#{album.id}")
    fill_in('song_name', :with => "La femme d'argent")
    click_on('Add song')
    expect(page).to have_content("La femme d'argent")
  end
end
