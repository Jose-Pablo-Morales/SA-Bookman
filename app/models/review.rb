class Review < ApplicationRecord
  belongs_to :book

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks


  settings do
    mappings dynamic: false do
      indexes :review, type: :text
      indexes :score, type: :integer
      indexes :up_votes, type: :integer
    end
  end

  def as_indexed_json(options = {})
    {
      review: review,
      score: score,
      up_votes: up_votes
    }
  end

  def self.search(query)
    if query.present?
      __elasticsearch__.search(
        {
          query: {
            multi_match: {
              query: query,
              fields: ['review^2']  
            }
          }
        }
      ).records
    else
      all
    end
  end
end
