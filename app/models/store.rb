class Store < ApplicationRecord
    # Associations
    has_one :admin
    has_many :employees
    # Validations
    validates :name, presence: true, length: { minimum: 2 }
    validates :address, presence: true, length: { minimum: 2 }
end
