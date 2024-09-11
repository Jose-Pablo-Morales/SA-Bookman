Elasticsearch::Model.client = Elasticsearch::Client.new(
  url: 'http://elasticsearch:9200'
)

if Rails.env.development? || Rails.env.production?
  begin
    Book.__elasticsearch__.create_index!(force: true) unless Book.__elasticsearch__.index_exists?
    Book.import if Book.count > 0
  rescue => e
    Rails.logger.error { "Elasticsearch setup error: #{e.message}" }
  end
end
