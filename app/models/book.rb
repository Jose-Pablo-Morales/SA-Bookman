class Book < ApplicationRecord
  belongs_to :author
  has_many :reviews
  has_many :sales

  def self.search(query)
    if query.present?
      where("LOWER(summary) LIKE ?", "%#{query.downcase}%")
    else
      all
    end
  end
end