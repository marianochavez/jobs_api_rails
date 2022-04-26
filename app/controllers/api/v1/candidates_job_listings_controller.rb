class Api::V1::CandidatesJobListingsController < ApplicationController
  def index
    @candidate_job_listing = CandidatesJobListing.all
    render json: { message: "Loaded all Job Listing of Candidate", data: @candidate_job_listing }
  end

  # TODO: me anula la primary key el modelo
  def show
    @candidate_job_listing = CandidatesJobListing.find(params[:id])
    if @candidate_job_listing
      render json: { message: "A Job Listing with that id was not found" }
    else
      render json: { message: "Loaded Job Listing by id of Candidate", data: @candidate_job_listing }
    end

  end

  def new
    @candidate = Candidate.find(params[:candidate_id])
    @candidate_job_listing = @candidate.job_listings.new
  end

  def create
    @candidate = Candidate.find(params[:candidate_id])
    @candidate_job_listing = CandidatesJobListing.new(candidate_job_listing_params)
    if @candidate_job_listing.save
      render json: { status: "SUCCESS", message: "create relation candidate - job_listing", data: @candidate_job_listing }
    end
  end

  # TODO: Not working
  def update
    @candidate_job_listing = CandidatesJobListing.where(candidate_id: params[:candidate_id], job_listing_id: params[:id])
    if @candidate_job_listing.update(candidate_id: params[:candidate_id], job_listing_id: params[:job_listing_id])
      render json: { status: "SUCCESS", message: "Updated candidate - job_listing", data: @candidate_job_listing }
    else
      render json: { message: "Updated error", data: @candidate_job_listing }
    end
  end

  #TODO: le falta el ID para eliminar
  def destroy
    @candidate_job_listing = CandidatesJobListing.where(id: params[:id])
    @candidate_job_listing.destroy
    render json: { status: "SUCCESS", message: "Deleted candidate - job_listing", data: @candidate_job_listing }
  end

  private

  def candidate_job_listing_params
    params.require(:candidates_job_listing).permit(:candidate_id, :job_listing_id)
  end
end
