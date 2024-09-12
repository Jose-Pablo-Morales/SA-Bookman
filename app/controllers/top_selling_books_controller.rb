class TopSellingBooksController < ApplicationController
    # def index
    #   @top_books = Book.joins(:author)
    #                    .select('books.*, authors.name AS author_name, 
    #                             authors.id AS author_id, 
    #                             SUM(books.number_of_sales) OVER(PARTITION BY books.author_id) AS total_author_sales')
    #                    .order('books.number_of_sales DESC')
    #                    .limit(50)
  
    #   @top_books_data = @top_books.map do |book|
    #     {
    #       book_name: book.name,
    #       author_name: book.author_name,
    #       total_book_sales: book.number_of_sales,
    #       total_author_sales: book.total_author_sales,
    #       top_5_in_year: book.was_top_5_in_year_of_publication?
    #     }
    #   end
    # end
    
    def index
      @top_books_data = Rails.cache.fetch("top_selling_books", expires_in: 30.minutes) do
        top_books = Book.joins(:author)
                        .select('books.*, authors.name AS author_name, 
                                 authors.id AS author_id, 
                                 SUM(books.number_of_sales) OVER(PARTITION BY books.author_id) AS total_author_sales')
                        .order('books.number_of_sales DESC')
                        .limit(50)
    
        top_books.map do |book|
          {
            book_name: book.name,
            author_name: book.author_name,
            total_book_sales: book.number_of_sales,
            total_author_sales: book.total_author_sales,
            top_5_in_year: book.was_top_5_in_year_of_publication?
          }
        end
      end
    end
  end
  