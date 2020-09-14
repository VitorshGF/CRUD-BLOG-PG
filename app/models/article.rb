class Article < ApplicationRecord
  belongs_to :user  # Many to One Side, FK
  # Contraints al Article
  validates :title, presence: true, length: { minimum: 6, maximum: 50 }
  validates :description, presence: true, length: { minimum: 8, maximum: 200 }
end
