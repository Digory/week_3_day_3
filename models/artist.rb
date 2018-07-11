require_relative('../db/sql_runner.rb')
require_relative('album.rb')
require('pry')

class Artist

  attr_reader :name, :id
  attr_writer :name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def self.all()
    sql = "SELECT * FROM artists"
    array_of_hashes = SqlRunner.run(sql)
    array_of_artists = array_of_hashes.map{|hash| Artist.new(hash)}
    return array_of_artists
  end

  def self.delete_all()
    sql = "DELETE FROM artists"
    SqlRunner.run(sql)
  end

  def save()
    sql = "INSERT INTO artists (name) VALUES ($1) RETURNING id"
    values = [@name]
    array_of_hashes = SqlRunner.run(sql,values)
    @id = array_of_hashes[0]['id'].to_i
  end

  def albums()
    sql = "SELECT * FROM albums WHERE artist_id = $1"
    values = [ @id ]
    array_of_hashes = SqlRunner.run(sql, values)
    return array_of_hashes.map { |album_hash| Album.new(album_hash) }
  end

  def update()
    sql = "UPDATE artists SET name = $1 WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM artists where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.find(id)
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [id]
    array_of_hashes = SqlRunner.run(sql,values)
    artist = Artist.new(array_of_hashes.first)
    return artist
  end


end
