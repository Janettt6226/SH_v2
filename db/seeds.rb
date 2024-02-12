# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Game.destroy_all
Role.destroy_all

game_1 = Game.create!

puts "======================="
puts "A game has been created"
puts "======================="

11.times do
  Law.create!(title: "Fascist",game: game_1)
end

6.times do
  Law.create!(title: "Liberal",game: game_1)
end

puts "======================="
puts "Stack is ready"
puts "======================="

Board.create!(game: game_1)

puts "======================="
puts "The Board is created ==> Game is ready"
puts "======================="
