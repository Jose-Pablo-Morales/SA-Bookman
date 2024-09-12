class Author < ApplicationRecord
    has_many :books
    has_one_attached :profile_image
    
    def total_sales
        books.sum(:number_of_sales)
      end
end
