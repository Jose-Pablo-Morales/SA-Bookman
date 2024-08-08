class Book < ApplicationRecord
  belongs_to :author
  has_many :reviews
  has_many :sales

  def self.top_50_selling_books
    select('books.*, 
            SUM(sales.sales) AS total_sales,
            authors.name AS author_name,
            (SELECT SUM(s.sales) FROM sales s 
             JOIN books b ON b.id = s.book_id 
             WHERE b.author_id = books.author_id) AS author_total_sales,
            (SELECT COUNT(*) FROM sales s2 
             WHERE s2.book_id = books.id 
             AND s2.sales >= (SELECT MAX(s2.sales) 
                              FROM sales s2 
                              WHERE s2.year = books.publication_date.year) - 4) AS top_5_of_year')
    .joins(:author, :sales)
    .group('books.id, authors.id')
    .order('total_sales DESC')
    .limit(50)
  end
end
