class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.string :name
      t.string :email
      t.string :position
      t.integer :private_number, unique: true

      t.timestamps
    end
    add_index :employees, :private_number, unique: true
  end
end
