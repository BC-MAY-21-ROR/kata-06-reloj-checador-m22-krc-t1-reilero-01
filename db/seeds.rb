# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Store.delete_all
Admin.delete_all
Attendance.delete_all
Employee.delete_all

1.times do
  admin = Admin.create! email: 'admin@admin.com', password: '123456'
  puts "Created a new user: #{admin.email}"
  3.times do
    store = Store.create!(
      name: "Company Checker - #{Faker::Company.name}",
      address: Faker::Address.street_address,
    )
      count = 1
      puts "Created a brand new product: #{store.name}"

      10.times do
          employee = Employee.create!(
          name: Faker::Name.name_with_middle,
          email: Faker::Internet.email,
          position: Faker::Job.position,
          private_number: Faker::Number.number(digits: 9),
          store_id: store.id,
          operative: true,
        )
        employee.avatar.attach(io: File.open(Rails.root.join("app/assets/images/profiles/profile#{count}.jpg")),
        filename: "profile#{count}.jpg")
        count += 1
        10.times do
           date = Faker::Time.between(from: 2.years.ago, to: DateTime.now)
            Attendance.create!(
              checked_in: date,
              checked_out: date + rand(15..500).minutes,
              employee_id: employee.id,
              )
          end
      end
    end
  end

#seeds