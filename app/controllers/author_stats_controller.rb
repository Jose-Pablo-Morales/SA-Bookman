class AuthorStatsController < ApplicationController
  # def index
  #   @authors = Author.joins(:books)
  #                    .select('authors.*, COUNT(books.id) AS books_count, 
  #                             AVG(reviews.score) AS average_score, 
  #                             SUM(sales.sales) AS total_sales')
  #                    .joins(books: :reviews)
  #                    .joins(books: :sales)
  #                    .group('authors.id')
  # end
  
  def index
    @authors = Author.joins(:books)
                     .select('authors.*, COUNT(books.id) AS books_count, 
                              AVG(reviews.score) AS average_score, 
                              SUM(sales.sales) AS total_sales')
                     .joins(books: :reviews)
                     .joins(books: :sales)
                     .group('authors.id')
  end
end
