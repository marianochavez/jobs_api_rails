class Api::V1::CompaniesController < ApplicationController

  before_action :find_company, only: [:show,:update,:destroy]

  def index
    @companies = Company.all.order('created_at DESC')
    render json: { status: 'SUCCESS', message: 'Loaded companies', data: @companies }, status: :ok
  end

  def show
    if @company
      render json: { status: 'SUCCESS', message: 'Loaded company', data: @company }, status: :ok
    else
      render json: { status: 'ERROR', message: "Company not found" }, status: 404
    end
  end

  def create
    company = Company.new(company_params)
    if company.save
      render json: { status: 'SUCCESS', message: 'Saved company', data: company }, status: :ok
    else
      render json: { status: 'ERROR', message: "Company not saved", data: company.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @company.update(company_params)
      render json: { status: 'SUCCESS', message: 'Updated company', data: @company }, status: :ok
    else
      render json: { status: 'ERROR', message: "Company not updated", data: @company.errors },
             status: :unprocessable_entity
    end
  end

  def destroy
    if @company.destroy
      render json: { status: 'SUCCESS', message: "Deleted company", data: @company }, status: :unprocessable_entity
    else
      render json: { status: 'ERROR', message: "Company not deleted" }, status: :unprocessable_entity
    end

  end

  private

  def company_params
    params.require(:company).permit([:name, :description, :address, :phone])
  end

  def find_company
    @company = Company.find(params[:id])
  end

end
