class Sale < ApplicationRecord
  belongs_to :book

  after_commit :clear_cache

  private

  def clear_cache
    Rails.cache.delete("top_selling_books")
    Rails.cache.delete("author_stats")
  end
end
