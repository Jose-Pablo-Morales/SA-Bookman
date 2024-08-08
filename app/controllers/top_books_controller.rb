class TopBooksController < ApplicationController
  def index
    @books = Book.joins(:reviews)
                 .select('books.*, AVG(reviews.score) as average_score')
                 .group('books.id')
                 .order('average_score DESC')
                 .limit(10)
  end
end
