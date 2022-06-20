class Employee < ApplicationRecord
  paginates_per 6

  has_many :attendance
  belongs_to :store
  has_one_attached :avatar
end
