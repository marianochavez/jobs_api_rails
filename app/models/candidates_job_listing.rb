class CandidatesJobListing < ApplicationRecord

  belongs_to :candidate
  belongs_to :job_listing
end
