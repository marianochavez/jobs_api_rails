class Api::V1::CompaniesController < ApplicationController

  before_action :set_company, only: [:show, :update, :destroy]
  before_action :check_token, only: [:update, :destroy]

  def index
    @companies = Company.all
    render status: :ok, json: { status: 'SUCCESS', message: 'Loaded companies', data: @companies }
  end

  def show
    render json: { status: 'SUCCESS', message: 'Loaded company', data: @company }, status: :ok
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      render json: { status: 'SUCCESS', message: 'Saved company', data: @company }, status: :created
    else
      render json: { status: 'ERROR', message: "Company not saved", errors: @company.errors }, status: 400
    end
  end

  def update
    if @company.update(company_params)
      render json: { status: 'SUCCESS', message: 'Updated company', data: @company }, status: :ok
    else
      render json: { status: 'ERROR', message: "Company not updated", errors: @company.errors }, status: 400
    end
  end

  def destroy
    if @company.destroy
      render json: { status: 'SUCCESS', message: "Deleted company", data: @company }, status: :ok
    else
      render json: { status: 'ERROR', message: "Company not deleted", errors: @company.errors }, status: 400
    end
  end

  private

  def company_params
    params.require(:company).permit([:name, :description, :address, :phone])
  end

  def set_company
    @company = Company.find_by(id: params[:id])
    return if @company.present?

    render json: { status: 'ERROR', message: "Company not found" }, status: 404
    false
  end

  def check_token
    return if request.headers['Authorization'] == "Bearer #{@company.token}"

    render json: { status: 'ERROR', message: "Unauthorized" }, status: 401
    false
  end

end
