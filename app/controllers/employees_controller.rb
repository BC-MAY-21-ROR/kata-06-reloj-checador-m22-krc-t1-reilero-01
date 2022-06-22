class EmployeesController < ApplicationController
  before_action :authenticate_admin!
  def index
    @employee = Employee.all
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
      redirect_to dashboard_root_path
    else
      render :edit , status: :unprocessable_entity
    end
  end

  def destroy
    @employee = Employee.find(params[:id])
    status = !@employee.operative
    @employee.update_column(:operative, status)

    respond_to do |format|
      format.html { redirect_to dashboard_root_path }
    end
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      redirect_to dashboard_root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def employee_params
    params.require(:employee).permit(:name, :email, :position, :private_number, :store_id, :avatar)
  end
end