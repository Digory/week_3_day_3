require_relative('../db/sql_runner.rb')
require_relative('artist.rb')
require('pry')

class Album

  attr_reader :id, :title, :genre, :artist_id
  attr_writer :title, :genre, :artist_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @genre = options['genre']
    @artist_id = options['artist_id']
  end

  def self.all()
    sql = "SELECT * FROM albums"
    array_of_hashes = SqlRunner.run(sql)
    array_of_albums = array_of_hashes.map{|hash| Album.new(hash)}
    return array_of_albums
  end

  def self.delete_all()
    sql = "DELETE FROM albums"
    SqlRunner.run(sql)
  end

  def save()
    sql = "INSERT INTO albums (title, genre, artist_id) VALUES ($1, $2, $3) RETURNING id"
    values = [@title, @genre, @artist_id]
    array_of_hashes = SqlRunner.run(sql,values)
    @id = array_of_hashes[0]['id'].to_i
  end

  def artist()
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [@artist_id]
    array_of_hashes = SqlRunner.run(sql,values)
    artist_hash = array_of_hashes[0]
    artist = Artist.new(artist_hash)
  return artist
  end

  def update()
  sql = "
  UPDATE albums SET (title, genre, artist_id) = ($1, $2, $3)
  WHERE id = $4"
  values = [@title, @genre, @artist_id, @id]
  SqlRunner.run(sql,values)
  end

  def delete()
    sql = "DELETE FROM albums where id = $1"
    values = [@id]
    SqlRunner.run(sql,values)
  end

  def self.find(id)
    sql = "SELECT * FROM albums WHERE id = $1"
    values = [id]
    array_of_hashes = SqlRunner.run(sql,values)
    albums = array_of_hashes.map{|each_hash| Album.new(each_hash)}
    return albums
  end


end
