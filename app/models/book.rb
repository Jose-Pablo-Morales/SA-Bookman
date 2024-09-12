class Book < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  
  belongs_to :author
  has_many :reviews
  has_many :sales
  has_one_attached :cover_image

  settings do
    mappings dynamic: false do
      indexes :name, type: :text                  
      indexes :summary, type: :text
      indexes :author_name, type: :text
    end
  end

  def as_indexed_json(options = {})
    {
      name: name,                                
      summary: summary,
      author_name: author.name,
      publication_date: publication_date
    }
  end

  def self.search(query)
    if query.present?
      __elasticsearch__.search(
        {
          query: {
            multi_match: {
              query: query,
              fields: ['name^2', 'summary', 'author_name'] 
            }
          }
        }
      ).records
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
end
