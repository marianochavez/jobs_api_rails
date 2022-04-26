class Api::V1::CandidatesController < ApplicationController

  before_action :find_candidate, only: [:show, :update, :destroy]

  def index
    @candidates = Candidate.all.order('created_at DESC')
    render json: { status: 'SUCCESS', message: 'Loaded candidates', data: @candidates }, status: :ok
  end

  def show
    if @candidate
      render json: { status: 'SUCCESS', message: 'Loaded candidate', data: @candidate }, status: :ok
    else
      render json: { status: 'ERROR', message: "Candidate not found" }, status: 404
    end
  end

  def new
    @candidate = Candidate.new
  end

  def create
    @candidate = Candidate.new(candidate_params)

    if @candidate.save
      render json: { status: 'SUCCESS', message: 'Saved candidate', data: @candidate }, status: :ok
    else
      render json: { status: 'ERROR', message: "Candidate not saved", data: :new },
             status: :unprocessable_entity
    end
  end

  def update
    if @candidate.update(company_params)
      render json: { status: 'SUCCESS', message: 'Updated candidate', data: @candidate }, status: :ok
    else
      render json: { status: 'ERROR', message: "Candidate not updated", data: @candidate.errors },
             status: :unprocessable_entity
    end
  end

  def destroy
    if @candidate.destroy
      render json: { status: 'SUCCESS', message: "Deleted candidate", data: @candidate }, status: :unprocessable_entity
    else
      render json: { status: 'ERROR', message: "Candidate not deleted" }, status: :unprocessable_entity
    end

  end

  private

  def candidate_params
    params.require(:candidate).permit([:name, :lastname, :email, :phone])
  end

  def find_candidate
    @candidate = Candidate.find(params[:id])
  end

end
