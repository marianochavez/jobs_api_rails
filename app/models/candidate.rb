class Candidate < ApplicationRecord

  has_many :candidate_job_listings, dependent: :destroy
  has_many :job_listings, through: :candidate_job_listings

  validates :name, presence: true, length: { minimum: 3, maximum: 15 }
  validates :lastname, presence: true, length: { minimum: 3, maximum: 10 }
  validates :email, presence: true
  validates :phone, presence: true, length: { minimum: 5, maximum: 30 }
end
