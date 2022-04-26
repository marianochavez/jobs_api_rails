class Candidate < ApplicationRecord

  validates :name, presence: true, length: { minimum: 3, maximum: 15 }
  validates :lastname, presence: true, length: { minimum: 3, maximum: 10 }
  validates :email, presence: true
  validates :phone, presence: true, length: { minimum: 5, maximum: 15 }
end
