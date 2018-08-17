require 'mongo'
Mongo::Logger.logger.level = ::Logger::INFO
db = Mongo::Client.new('mongodb://localhost:27017')
db = db.use('test')

#Create
#db[:zips].insert_one(_id: "123123123", city: "Magic Land",
#                     loc: [ 21.15327,-101.60057],
#                     pop: 2000000, state: "CA")

#Create Many
#db[:zips].insert_many([{_id: "123123124", city: "San Miguel de Allende",
#                     loc: [20.9152800, -100.7438900],
#                     pop: 2000000, state: "GTO"},
#                     {_id: "123123125", city: "San Francisco del Rincon",
#                     loc: [20.99770,-101.81554],
#                     pop: 2000000, state: "GTO"}])

gto   = db[:zips].find(state: "GTO")
magic = db[:zips].find(city: "Magic Land")
biggest = db[:zips].find(pop: { "$gt": 1000000 }).first
puts "\nDatabase name: #{ db.database.name }\n"
puts "*" * 20
puts "\nFirst: #{ db[:zips].find.first } \n"
puts "*" * 20
puts "\nMagic Cities #{ magic.count}: #{ magic.to_a }\n"
puts "*" * 20
puts "\nGto cities #{ gto.count }: #{ gto.to_a }"

puts "*" * 20
puts "\nBig city #{ biggest["city"] }: population #{ biggest["pop"] }"
