class Company < ApplicationRecord

  has_many :job_listings, dependent: :destroy

  validates :name, presence: true, length: { minimum: 2, maximum: 15 }
  validates :description, presence: true, length: { minimum: 5, maximum: 50 }
  validates :address, presence: true, length: { minimum: 10, maximum: 30 }
  validates :phone, presence: true, length: { minimum: 5, maximum: 15 }
  validates :token, uniqueness: true

  before_create :set_token

  def set_token
    self.token = SecureRandom.uuid
  end

end
