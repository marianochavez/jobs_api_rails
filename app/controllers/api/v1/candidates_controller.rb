class Api::V1::CandidatesController < ApplicationController

  before_action :find_candidate, only: [:show, :update, :destroy]

  def index
    @candidates = Candidate.all
    render json: { status: 'SUCCESS', message: 'Loaded candidates', data: @candidates }, status: :ok
  end

  def show
    render json: { status: 'SUCCESS', message: 'Loaded candidate', data: @candidate }, status: :ok
  end

  def create
    @candidate = Candidate.new(candidate_params)
    if @candidate.save
      render json: { status: 'SUCCESS', message: 'Saved candidate', data: @candidate }, status: :created
    else
      render json: { status: 'ERROR', message: "Candidate not saved", errors: @candidate.errors }, status: 400
    end
  end

  def update
    if @candidate.update(company_params)
      render json: { status: 'SUCCESS', message: 'Updated candidate', data: @candidate }, status: :ok
    else
      render json: { status: 'ERROR', message: "Candidate not updated", errors: @candidate.errors }, status: 400
    end
  end

  def destroy
    if @candidate.destroy
      render json: { status: 'SUCCESS', message: "Deleted candidate", data: @candidate }, status: :unprocessable_entity
    else
      render json: { status: 'ERROR', message: "Candidate not deleted", errors: @candidate.errors }, status: 400
    end

  end

  private

  def candidate_params
    params.require(:candidate).permit([:name, :lastname, :email, :phone])
  end

  def find_candidate
    @candidate = Candidate.find(params[:id])
    if !@candidate
      render json: { status: 'ERROR', message: "Candidate not found" }, status: 404
    end
  end

end
