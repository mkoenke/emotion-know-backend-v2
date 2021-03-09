# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Parent.destroy_all
# puts "destoying parents"
# Child.destroy_all
# puts "destroying children"
JournalEntry.destroy_all
puts "destroying journal entries"
Report.destroy_all
puts "destroying reports"
AudioReport.destroy_all
puts "destroying audio reports"
AudioEntry.destroy_all
puts "destroying audio entries"
VideoReport.destroy_all
puts "destroying video reports"
VideoEntry.destroy_all
puts "destroying video entries"


parent = Parent.create!(email: "mkoenke@sas.upenn.edu", password_digest: BCrypt::Password.create("1234"))

puts "Parent seeded"

child = Child.create!(username: "Angelina", password_digest: BCrypt::Password.create("1234"), image: "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIP.1YM53mG10H_U25iPjop83QHaEo%26pid%3DApi&f=1", parent_id: parent.id)
puts "Child seeded"

# journal_entry = JournalEntry.create!(title: "Day 1", child_id: child.id, content: "Today was a good day")
# puts "Journal seeded"

# report = Report.create!(title: "Day 1", journal_entry_id: journal_entry.id, parent_id: parent.id)
# puts "Report seeded"