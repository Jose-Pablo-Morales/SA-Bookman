class Author < ApplicationRecord
 
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  has_many :books
  has_one_attached :profile_image

  def total_sales
      books.sum(:number_of_sales)
    end



  settings do
    mappings dynamic: false do
      indexes :name, type: :text
      indexes :country_of_origin, type: :text
      indexes :description, type: :text
    end
  end

  def as_indexed_json(options = {})
    {
      name: name,
      country_of_origin: country_of_origin,
      description: description
    }
  end

  def self.search(query)
    if query.present?
      __elasticsearch__.search(
        {
          query: {
            multi_match: {
              query: query,
              fields: ['name^2', 'country_of_origin', 'description']
            }
          }
        }
      ).records
    else
      all
    end
  end
end
