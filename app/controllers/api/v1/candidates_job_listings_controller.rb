class Api::V1::CandidatesJobListingsController < ApplicationController

  before_action :find_candidate_job_listing, only: [:show, :update, :destroy]

  def index
    @candidate_job_listings = CandidateJobListing.all
    render json: { message: "Loaded all candidates - Job_listing ", data: @candidate_job_listings }, status: :ok
  end

  def show
    render json: { status: "SUCCESS", message: "Loaded candidate job_listing", data: @candidate_job_listing },status: :ok
  end

  def create
    @candidate = Candidate.find_by(id: params[:candidate_id])
    @candidate_job_listing = @candidate.candidate_job_listings.new(candidate_job_listing_params)
    if @candidate_job_listing.save
      render json: { status: "SUCCESS", message: "Created candidate job_listing", data: @candidate_job_listing },
             status: :created
    else
      render json: { status: "ERROR", message: "Candidate job_listing not created", errors: @candidate_job_listing.errors },
             status: 400
    end
  end

  def update
    if @candidate_job_listing.update(candidate_job_listing_params)
      render json: { status: "SUCCESS", message: "Updated candidate job_listing", data: @candidate_job_listing },
             status: :ok
    else
      render json: { message: "Candidate job_listing not updated", errors: @candidate_job_listing.errors }, status: 400
    end
  end

  def destroy
    if @candidate_job_listing.destroy
      render json: { status: "SUCCESS", message: "Deleted candidate job_listing", data: @candidate_job_listing }
    else
      render json: { message: "Candidate job_listing not deleted", errors: @candidate_job_listing.errors }, status: 400
    end

  end

  private

  def candidate_job_listing_params
    params.require(:candidates_job_listing).permit(:candidate_id, :job_listing_id, :status)
  end

  def find_candidate_job_listing
    @candidate_job_listing = CandidateJobListing.find_by(id: params[:id])
    if !@candidate_job_listing
      render json: {status: "ERROR", message: "A candidate job listing with that id was not found"}, status: 404
    end
  end
end
