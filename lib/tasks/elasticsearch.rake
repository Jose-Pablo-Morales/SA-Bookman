# lib/tasks/opensearch.rake
namespace :opensearch do
    desc 'Create the books index'
    task create_books_index: :environment do
      OpenSearchClient.indices.create(index: 'books', body: {
        mappings: {
          properties: {
            title: { type: 'text' },
            summary: { type: 'text' },
            publication_date: { type: 'date' }
          }
        }
      })
    end

    desc 'Create the authors index'
    task create_authors_index: :environment do
      OpenSearchClient.indices.create(index: 'authors', body: {
        mappings: {
          properties: {
            name: { type: 'text' },
            country_of_origin: { type: 'text' },
            description: { type: 'text' }
          }
        }
      })
    end
  
    desc 'Create the reviews index'
    task create_reviews_index: :environment do
      OpenSearchClient.indices.create(index: 'reviews', body: {
        mappings: {
          properties: {
            review: { type: 'text' },
            score: { type: 'integer' },
            up_votes: { type: 'integer' }
          }
        }
      })
    end
  end