class Author < ApplicationRecord
    has_many :books
    
    def total_sales
        books.sum(:number_of_sales)
      end
end
