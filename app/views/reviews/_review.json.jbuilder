json.extract! review, :id, :book_id, :review, :score, :up_votes, :created_at, :updated_at
json.url review_url(review, format: :json)
