json.extract! book, :id, :name, :summary, :publication_date, :number_of_sales, :author_id, :created_at, :updated_at
json.url book_url(book, format: :json)
