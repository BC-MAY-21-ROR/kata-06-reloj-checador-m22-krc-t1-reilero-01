class DashboardController < ApplicationController
  def index
    @employees = Employee.all.order(:id)
  end

  def show
    @employee = Employee.find(params[:id])
  end

  def new
    @employee = Employee.new
  end

  def edit
    @employee = Employee.find(params[:id])
  end

  def update
    @employee = Employee.find(params[:id])
    if @employee.update(employee_params)
      redirect_to dashboard_index_path
    else
      render 'edit'
    end
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      redirect_to dashboard_index_path
    else
      render :new
    end
  end

  private

  def employee_params
    params.permit(:name, :email, :position, :private_number, :store_id)
  end
end
