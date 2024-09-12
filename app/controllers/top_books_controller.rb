class TopBooksController < ApplicationController
  # def index
  #   @books = Book.joins(:reviews)
  #                .select('books.*, AVG(reviews.score) as average_score')
  #                .group('books.id')
  #                .order('average_score DESC')
  #                .limit(10)
  # end

  def index
    @books = Rails.cache.fetch("top_books", expires_in: 30.minutes) do
      Book.joins(:reviews)
          .select('books.*, AVG(reviews.score) as average_score')
          .group('books.id')
          .order('average_score DESC')
          .limit(10)
    end
  end
end
