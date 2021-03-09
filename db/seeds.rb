Parent.destroy_all
puts "destoying parents"
Child.destroy_all
puts "destroying children"

parent = Parent.create!(email: "mkoenke@sas.upenn.edu", password_digest: BCrypt::Password.create("1234"))
puts "Parent seeded"
child = Child.create!(username: "Angelina", password_digest: BCrypt::Password.create("1234"), image: "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIP.1YM53mG10H_U25iPjop83QHaEo%26pid%3DApi&f=1", parent_id: parent.id)
puts "Child seeded"

VideoReport.destroy_all
puts "destroying video reports"
VideoEntry.destroy_all
puts "destroying video entries"