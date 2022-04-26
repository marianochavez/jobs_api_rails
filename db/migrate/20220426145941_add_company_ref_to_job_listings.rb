class AddCompanyRefToJobListings < ActiveRecord::Migration[7.0]
  def change
    add_reference :job_listings, :company, null: false, foreign_key: true
  end
end
