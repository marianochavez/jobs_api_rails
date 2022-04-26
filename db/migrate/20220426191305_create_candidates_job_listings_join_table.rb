class CreateCandidatesJobListingsJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_join_table :candidates, :job_listings, id: true do |t|

      t.timestamps
    end
  end
end
