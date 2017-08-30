# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Product.with_name('Movie Ticket').first_or_create!(price: 19.99)
Product.with_name('Popcorn').first_or_create!(price: 6.99)
Product.with_name('Milk Duds').first_or_create!(price: 2.99)
