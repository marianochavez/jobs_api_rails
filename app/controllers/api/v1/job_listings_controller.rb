class Api::V1::JobListingsController < ApplicationController

  before_action :set_job_listing, only: [:show, :update, :destroy, :apply, :remove]
  before_action :set_company, only: [:create, :update, :destroy]
  before_action :check_token, only: [:create, :update, :destroy]
  before_action :check_token_candidate, only: [:apply, :remove]

  def index
    @job_listings = JobListing.all
    render json: { status: 'SUCCESS', message: 'Loaded job listings', data: @job_listings }, status: :ok
  end

  def show
    render json: { status: 'SUCCESS', message: 'Loaded job listings', data: @job_listing }, status: :ok
  end

  def create
    @job_listing = @company.job_listings.new(job_listing_params)
    if @job_listing.save
      render json: { status: 'SUCCESS', message: 'Created job listing', data: @job_listing }, status: :created
    else
      render json: { status: 'ERROR', message: 'Job listing not created', errors: @job_listing.errors }, status: 400
    end
  end

  # apply to job, candidate token required
  def apply
    @candidate_job_listing = CandidateJobListing.find_or_initialize_by(candidate_id: params[:candidate_id], job_listing_id: @job_listing.id)

    if @candidate_job_listing.persisted?
      render json: { status: 'SUCCESS', message: 'Already applied candidate job listing', data: @candidate_job_listing }, status: :created
    elsif @candidate_job_listing.save
      render json: { status: 'SUCCESS', message: 'Applied candidate job listing', data: @candidate_job_listing }, status: :ok
    else
      render json: { status: 'ERROR', message: 'Candidate job listing not created', errors: @candidate_job_listing.errors }, status: 400
    end
  end

  def update
    if @job_listing.update(job_listing_params)
      render json: { status: 'SUCCESS', message: 'Updated job listing', data: @job_listing }, status: :ok
    else
      render json: { status: 'ERROR', message: 'Job listing not updated', errors: @job_listing.errors }, status: 400
    end
  end

  # remove applied job, candidate token required
  def remove
    if @job_listing.destroy
      render json: { status: 'SUCCESS', message: 'Removed job listing from candidate', data: @job_listing }, status: :ok
    else
      render json: { status: 'ERROR', message: 'Error removing job listing from candidate', errors: @job_listing.errors }, status: 400
    end
  end

  def destroy
    if @job_listing.destroy
      render json: { status: 'SUCCESS', message: 'Deleted job listing', data: @job_listing }, status: :ok
    else
      render json: { status: 'ERROR', message: 'Error deleting job listing', errors: @job_listing.errors }, status: 400
    end
  end

  private

  def job_listing_params
    params.require(:job_listing).permit(:title, :description, :start_date, :duration)
  end

  def set_job_listing
    @job_listing = JobListing.find_by(id: params[:id])
    return if @job_listing.present?

    render json: { status: 'ERROR', message: "Job listing not found" }, status: 404
    false
  end

  def set_company
    @company = Company.find_by(id: params[:company_id]) || @job_listing.company
    return if @company.present?

    render json: { status: 'ERROR', message: "Company not found" }, status: 404
    false
  end

  def check_token
    return if request.headers['Authorization'] == "Bearer #{@company.token}"

    render json: { status: 'ERROR', message: "Unauthorized" }, status: 401
    false
  end

  def check_token_candidate
    @candidate = Candidate.find_by(id: params[:candidate_id])
    return if request.headers['Authorization'] == "Bearer #{@candidate.token}"

    render json: { status: 'ERROR', message: "Unauthorized" }, status: 401
    false
  end

end
