# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'

50.times do
  Author.create(
    name: Faker::Book.author,
    date_of_birth: Faker::Date.birthday(min_age: 18, max_age: 65),
    country_of_origin: Faker::Address.country,
    description: Faker::Lorem.paragraph(sentence_count: 3)
  )
end

author_ids = Author.pluck(:id)

300.times do
  Book.create(
    name: Faker::Book.title,
    summary: Faker::Lorem.paragraph(sentence_count: 5),
    publication_date: Faker::Date.backward(days: 365 * 5), 
    number_of_sales: Faker::Number.between(from: 0, to: 10000),
    author_id: author_ids.sample
  )
end

Book.find_each do |book|
    rand(1..10).times do
      Review.create(
        book: book,
        review: Faker::Lorem.paragraph(sentence_count: 3),
        score: Faker::Number.between(from: 1, to: 5),
        up_votes: Faker::Number.between(from: 0, to: 100)
      )
    end
  end
  
  Book.find_each do |book|
   
    (0..4).each do |i|
      year = Date.today.year - i
      Sale.create(
        book: book,
        year: year,
        sales: Faker::Number.between(from: 0, to: 10000) 
      )
    end
  end