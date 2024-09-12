class Book < ApplicationRecord
  belongs_to :author
  has_many :reviews
  has_many :sales

  after_commit :clear_cache

  def self.search(query)
    if query.present?
      where("LOWER(summary) LIKE ?", "%#{query.downcase}%")
    else
      all
    end
  end

  def was_top_5_in_year_of_publication?
    yearly_sales = Sale.where(year: self.publication_date.year)
                       .joins(:book)
                       .group('books.id')
                       .sum(:sales)
                       
    rank = yearly_sales.sort_by { |_book_id, total_sales| -total_sales }.map(&:first).index(self.id)
    rank && rank < 5
  end

  private

  def clear_cache
    Rails.cache.delete("top_selling_books")
    Rails.cache.delete("top_books")
    Rails.cache.delete("author_stats")
  end
end