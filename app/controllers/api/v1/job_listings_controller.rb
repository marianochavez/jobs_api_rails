class Api::V1::JobListingsController < ApplicationController

  before_action :find_company, only: [:show, :update, :destroy]

  def index
    @job_listings = JobListing.all
    render json: { status: 'SUCCESS', message: 'Loaded job listings', data: @job_listings }, status: :ok
  end

  def show
    render json: { status: 'SUCCESS', message: 'Loaded job listings', data: @job_listing }, status: :ok
  end

  def create
    @company = Company.find_by(id: params[:company_id])
    @job_listing = @company.job_listings.new(job_listing_params)
    if @job_listing.save
      render json: { status: 'SUCCESS', message: 'Created job listing', data: @job_listing },status: :created
    else
      render json: { status: 'ERROR', message: 'Job listing not created', errors: @job_listing.errors },status: 400
    end
  end

  def update
    if @job_listing.update(job_listing_params)
      render json: { status: 'SUCCESS', message: 'Updated job listing', data: @job_listing }, status: :ok
    else
      render json: { status: 'ERROR', message: 'Job listing not updated', errors: @job_listing.errors },status: 400
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

  def find_job_listing
    @job_listing = JobListing.find_by(id: params[:id])
    if !@job_listing
      render json: { status: 'ERROR', message: "Job listing not found" }, status: 404
    end
  end
end
