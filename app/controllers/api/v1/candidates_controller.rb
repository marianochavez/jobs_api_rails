class Api::V1::CandidatesController < ApplicationController

  before_action :set_candidate, only: [:show, :update, :destroy]
  before_action :check_token, only: [:update, :destroy]

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
    if @candidate.update(candidate_params)
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

  def set_candidate
    @candidate = Candidate.find_by(id: params[:id])
    return if @candidate.present?

    render json: { status: 'ERROR', message: "Candidate not found" }, status: 404
    false
  end

  def check_token
    return if request.headers['Authorization'] == "Bearer #{@candidate.token}"

    render json: { status: 'ERROR', message: "Unauthorized" }, status: 401
    false
  end

end
