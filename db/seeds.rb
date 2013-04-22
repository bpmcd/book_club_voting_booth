# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

candidates = Candidate.create([ {name: "The Quiet American by Graham Greene"},
                              {name: "The End of the Affair by Graham Greene"},
                              {name: "The Sparrow by Mary Doria Russell"},
                              {name: "The Brief History of Time by Stephen Hawking"},
                              {name: "Angels and Demons by Dan Brown"},
                              {name: "Ender's Game by Orson Scott Card"},
                              {name: "Hitchhikers Guide to the Galaxy by Douglas Adams"},
                              {name: "Catch 22 by Joseph Heller"},
                              {name: "Little Brother by Cory Doctorow"},
                              {name: "Seventeen by Booth Tarkington"},
                              {name: "UFO's, JFK... Crazy to Believe by Richard Belzer"},
                              {name: "Samuri's Garden by Gail Tsukiyama"},
                              {name: "Cryptomonicon by Neal Stephenson"},
                              {name: "Beowulf by Unknown"},
                              {name: "Jane Eyre by Charlotte Bronte"} ])

e = Election.create({ title: "April Book Selection", end_date: Date.parse('2013-04-26') })
e.candidates = candidates
e.save

