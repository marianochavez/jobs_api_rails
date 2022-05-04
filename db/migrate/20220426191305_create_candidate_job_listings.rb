class CreateCandidateJobListings < ActiveRecord::Migration[7.0]
  def change
    create_table :candidate_job_listings do |t|
      t.belongs_to :candidate
      t.belongs_to :job_listing
      t.integer :state, default: 0
      t.timestamps
    end
  end
end
