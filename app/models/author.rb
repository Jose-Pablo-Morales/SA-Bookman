class Author < ApplicationRecord
    has_many :books
    
    after_commit :clear_cache

    def total_sales
        books.sum(:number_of_sales)
    end
    
    private
  
    def clear_cache
      Rails.cache.delete("author_stats")
    end
end
