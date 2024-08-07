json.extract! author, :id, :name, :date_of_birth, :country_of_origin, :description, :created_at, :updated_at
json.url author_url(author, format: :json)
