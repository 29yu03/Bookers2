class Book < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :body, presence: true
  validates :body, length: { maximum: 200, message: 'Opinion is too long (maximum is 200 characters)'}
end
