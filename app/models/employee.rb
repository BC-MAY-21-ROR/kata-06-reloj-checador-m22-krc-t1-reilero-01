class Employee < ApplicationRecord
  has_many :attendance
  has_one_attached :avatar
end
