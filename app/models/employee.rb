class Employee < ApplicationRecord
  paginates_per 6
  has_many :attendance
  has_one_attached :avatar
end
