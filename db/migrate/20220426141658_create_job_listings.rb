class CreateJobListings < ActiveRecord::Migration[7.0]
  def change
    create_table :job_listings do |t|
      t.string :title
      t.text :description
      t.date :start_date
      t.string :duration

      t.timestamps
    end
  end
end
