require_relative('../models/album.rb')
require_relative('../models/artist.rb')
#
# Album.delete_all()
# Artist.delete_all()
#


artist1 = Artist.new({
  'name' => 'Digory'
  })
artist2 = Artist.new({
  'name' => 'Emil'
  })
artist1.save()
artist2.save()

album1 = Album.new({
  'title' => 'Digory\'s greatest hits',
  'genre' => 'Acid Jazz',
  'artist_id' => artist1.id
  })
album2 = Album.new({
  'title' => 'Digory Volume 2',
  'genre' => 'Psychedelic Pop',
  'artist_id' => artist1.id
  })
album1.save()
album2.save()
album1.genre = 'Trip Hop'
album1.update()
artist2.name = 'Emilia'
artist2.update()

# album1.delete()
# artist2.delete()

p Album.find(43)
p Artist.find(55)
# p album1
# p artist1.albums()
# p album1.artist()
# p album2.artist()
# p Artist.all()
# p Album.all()
