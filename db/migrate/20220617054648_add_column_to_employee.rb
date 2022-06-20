class AddColumnToEmployee < ActiveRecord::Migration[7.0]
  def change
    add_column :employees, :operative, :boolean, default: true
  end
end
