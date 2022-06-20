class DashboardController < ApplicationController
  def index
    if params[:date_day].present?
      @attendances_day = Attendance.all.select do |attendance|
        attendance.checked_in.strftime("%Y-%m-%d") == "#{params[:date_day]}"  
      end
    end

    if params[:query].present?
      @employees = Employee.where("name LIKE ?", "%#{params[:query]}%").all.order(:id).page(params[:page] || 1)
    else
      @employees = Employee.all.order(:id).page(params[:page] || 1)
    end
  end

  def search
    @employees = Employee.where("name LIKE ?", "%#{params[:name_search]}%")
                  .all.order(:id)
                  .page(params[:page] || 1)
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [ 
          turbo_stream.update("search_results", 
          partial: "dashboard/search_results", locals: {employees: @employees})
          ]
      end
      format.html {render 'dashboard/index'	}
    end
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
      redirect_to dashboard_index_path
    else
      render :new
    end
  end

  private

  def employee_params
    params.permit(:name, :email, :position, :private_number, :store_id, :avatar)
  end
end
