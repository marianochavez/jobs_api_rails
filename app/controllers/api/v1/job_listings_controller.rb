class Api::V1::JobListingsController < ApplicationController

  # before_action :find_company, only: [:index, :show, :create, :update, :destroy]

  def index
    @company = Company.find(params[:company_id])
    @job_listings = @company.job_listings.order('created_at DESC')
    render json: { status: 'SUCCESS', message: 'Loaded job listings', data: { company: @company,
                                                                              job_listings: @job_listings} },
           status: :ok
  end

  def show
    @company = Company.find(params[:company_id])
    @job_listing = @company.job_listings.find(params[:id])
    render json: { status: 'SUCCESS', message: 'Loaded job listings', data: { company: @company,
                                                                              job_listing: @job_listing} },
           status: :ok
  end

  def new
    @company = Company.find(params[:company_id])
    @job_listing = @company.job_listings.new
  end

  def create
    @company = Company.find(params[:company_id])
    @job_listing = @company.job_listings.new(job_listing_params)
    if @job_listing.save
      render json: { status: 'SUCCESS', message: 'Created job listing', data: { company: @company,
                                                                                job_listing: @job_listing} },
             status: :ok
    end
  end

  def update
    @company = Company.find(params[:company_id])
    @job_listing = @company.job_listings.find(params[:id])

    if @job_listing.update(job_listing_params)
      render json: { status: 'SUCCESS', message: 'Updated job listing', data: { company: @company,
                                                                                job_listing: @job_listing} },
             status: :ok
    end
  end

  def destroy
    @company = Company.find(params[:company_id])
    @job_listing = @company.job_listings.find(params[:id])

    if @job_listing.destroy
      render json: { status: 'SUCCESS', message: 'Deleted job listing', data: { company: @company,
                                                                                job_listing: @job_listing} },
             status: :ok
    end
  end

  private

  def job_listing_params
    params.require(:job_listing).permit(:title, :description, :start_date, :duration)
  end
end
