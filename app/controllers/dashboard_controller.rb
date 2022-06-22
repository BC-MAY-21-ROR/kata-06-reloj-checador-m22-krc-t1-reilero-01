class DashboardController < ApplicationController
  before_action :authenticate_admin!

  def index
    if params[:date_day].present?
      @employees = Employee.joins(:attendance).where(attendances: {checked_in: (Time.parse("#{params[:date_day]}
        00:00:00")..Time.parse("#{params[:date_day]} 23:59:59"))}).order(:id).page(params[:page] || 1)
      @attendances_day = @employees.count

    elsif params[:query].present?
      @employees = Employee.where("name LIKE ?", "%#{params[:query]}%").order(:id).page(params[:page] || 1)
    
    elsif params[:absence_month].present?
 
      absence_month = params[:absence_month].split("-").reverse.join("/")
      employees =  Employee.joins(:attendance).where(attendances: {checked_in: (Time.parse(absence_month)
      .beginning_of_month..Time.parse(absence_month).end_of_month)})
      
      hash_employees_absence = {}
      
      employees.each do |employee|
        hash_employees_absence[employee] = (hash_employees_absence[employee] || 0) + 1
      end
      
      limit_day = Time.parse(absence_month).end_of_month.strftime("%d")
      absence_count = 0
      hash_employees_absence.each do |k, v|
         absence_count = absence_count + (limit_day.to_i - v)
      end
      @absence_by_month = absence_count + ((Employee.all.count - hash_employees_absence.count) * limit_day.to_i) 

      @employees = employees.order(:id).page(params[:page] || 1) 
    elsif params[:avg_month].present?
      
    else
      @employees = Employee.all.order(:id).page(params[:page] || 1)
    end
  end

end
