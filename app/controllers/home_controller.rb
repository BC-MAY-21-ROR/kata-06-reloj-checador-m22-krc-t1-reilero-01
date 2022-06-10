class HomeController < ApplicationController
  def index
  end

  def new
    
  end

  def parse_input
    private_number = params[:private_number]
    find_employee = Employee.find_by(private_number: private_number)
   if find_employee
      checked_in_create(find_employee)
      redirect_to root_path, notice: "Founded private number"
   else
      redirect_to root_path
      flash[:alert] = "Invalid private number"
   end
  end

  def checked_in_create(find_employee)
    time_now = Time.now.strftime("%d/%m/%Y")
    attendance_by_user = Attendance.find_by(employee_id: find_employee[:id])

    if !attendance_by_user.nil? 
        difference_time = [attendance_by_user].last.checked_in.strftime("%d/%m/%Y") != time_now
    end

    if attendance_by_user.nil? || difference_time
      Attendance.create!(checked_in: Time.now, employee_id: find_employee[:id])
    elsif attendance_by_user.checked_out.nil?
      [attendance_by_user].last.update(checked_out: Time.now) 
    end

    p Attendance.all
  end

end
