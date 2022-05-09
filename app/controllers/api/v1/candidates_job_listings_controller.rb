class Api::V1::CandidatesJobListingsController < ApplicationController

  before_action :set_candidate_job_listing, only: [:show, :update]
  before_action :check_token, only: [:update]
  before_action :check_state, only: [:update]

  def index
    @candidate_job_listings = CandidateJobListing.all
    render json: { message: "Loaded all candidates - Job_listing ", data: @candidate_job_listings }, status: :ok
  end

  def show
    render json: { status: "SUCCESS", message: "Loaded candidate job_listing", data: @candidate_job_listing }, status: :ok
  end

  def update
    if @candidate_job_listing.update(candidate_job_listing_params)
      render json: { status: 'SUCCESS', message: 'Updated candidate job listing status', data: @candidate_job_listing }, status: :ok
    else
      render json: { status: 'ERROR', message: 'Candidate job listing status not updated', errors: @candidate_job_listing.errors }, status: 400
    end
  end

  private

  def candidate_job_listing_params
    params.require(:candidates_job_listing).permit(:state)
  end

  def set_candidate_job_listing
    @candidate_job_listing = CandidateJobListing.find_by(id: params[:id])
    return if @candidate_job_listing.present?

    render json: { status: "ERROR", message: "A candidate job listing with that id was not found" }, status: 404
    false
  end

  def check_token
    @company = Company.find_by(id: params[:company_id])
    return if request.headers['Authorization'] == "Bearer #{@company.token}"

    render json: { status: 'ERROR', message: "Unauthorized" }, status: 401
    false
  end

  def check_state
    return if CandidateJobListing.states.values.include?(params[:state]) || CandidateJobListing.states.keys.include?(params[:state])

    render json: { status: 'ERROR', message: 'Invalid state', valid_states: CandidateJobListing.states }, status: 400
    false
  end
end
