class HomeController < ApplicationController
  def index
    
  end

  def private_number_input
    private_number = params[:private_number]
    if_employee_is_found(private_number)
  end
  
  def if_employee_is_found(private_number)
    find_employee = find_private_number_to_employee(private_number)
    if find_employee
       if attendance_create(find_employee)
        redirect_to root_path(find_employee), notice: "Found private number"
        flash[:employee] = [find_employee, Attendance.where(employee_id: find_employee[:id]).last]
       else
        redirect_to root_path, alert: "For today the private number is already used"
       end
    else
      redirect_to root_path, alert: "Invalid private number or employee is inoperative"
    end
  end
  
  def find_private_number_to_employee(private_number)
    Employee.find_by(private_number: private_number, operative: true)
  end
  
  def attendance_create(find_employee)
    time_now = Time.now.strftime("%d/%m/%Y")
    attendance_by_user = Attendance.where(employee_id: find_employee[:id]).last
    
    if !attendance_by_user.nil? 
      difference_time = attendance_by_user.checked_in.strftime("%d/%m/%Y") != time_now
    end
    
    if attendance_by_user.nil? || difference_time
      Attendance.create!(checked_in: Time.now, employee_id: find_employee[:id])
    elsif attendance_by_user.checked_out.nil?
      attendance_by_user.update(checked_out: Time.now) 
    end
  end

end
