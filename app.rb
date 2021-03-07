require 'sinatra'
require 'sinatra/reloader'
require 'pry'
require './lib/album'
require './lib/song'
also_reload 'lib/**/*.rb'

get('/') do
  redirect to('/albums')
end

get('/albums') do
  @albums = Album.all 
  erb(:albums)
end

get('/albums/new') do
  erb(:new_album)
end

post('/albums') do
  name = params[:album_name]
  artist = params[:album_artist]
  year = params[:album_year]
  genre = params[:album_genre]
  searched_album = params[:searched_name]
  if searched_album != nil 
    @searched_albums = Album.search(searched_album) 
  else
    album = Album.new({name: name, artist: artist, year: year, genre: genre})
    album.save()   
  end
  redirect to('/albums')
end

get('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  erb(:album)
end

get('/albums/:id/edit') do
  @album = Album.find(params[:id].to_i())
  erb(:edit_album)
end

patch('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  @album.update({name: params[:name], artist: params[:artist], year: params[:year], genre: params[:genre]})
  redirect to('/albums')
end

delete('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  @album.delete()
  redirect to('/albums')
end

get('/albums/:id/songs/:song_id') do
  @song = Song.find(params[:song_id].to_i())
  erb(:song)
end

post('/albums/:id/songs') do
  @album = Album.find(params[:id].to_i())
  song = Song.new({name: params[:song_name], album_id: @album.id})
  song.save()
  erb(:album)
end

patch('/albums/:id/songs/:song_id') do
  @album = Album.find(params[:id].to_i())
  song = Song.find(params[:song_id].to_i())
  song.update({name: params[:name], album_id: @album.id})
  erb(:album)
end

delete('/albums/:id/songs/:song_id') do
  song = Song.find(params[:song_id].to_i())
  song.delete
  @album = Album.find(params[:id].to_i())
  erb(:album)
end
