class JobListing < ApplicationRecord

  belongs_to :company

  validates :title, presence: true, length: { minimum: 5, maximum: 20 }
  validates :description, presence: true, length: { minimum: 10, maximum: 50 }
  validates :start_date, presence: true
  validates :duration, presence: true, length: { minimum: 4, maximum: 15 }
end
