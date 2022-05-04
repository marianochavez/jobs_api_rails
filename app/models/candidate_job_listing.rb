class CandidateJobListing < ApplicationRecord

  belongs_to :candidate
  belongs_to :job_listing

  # new changes
  enum state: { contratado: 2, interesa: 1, rechazado: 3, pendiente: 0} # hash
end
