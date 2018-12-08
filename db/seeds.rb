# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

makers = %w(T社 H社 M社 B社 S社)
makers.each do |maker|
  Maker.create!(name: maker)
end

puts 'Makers setup'