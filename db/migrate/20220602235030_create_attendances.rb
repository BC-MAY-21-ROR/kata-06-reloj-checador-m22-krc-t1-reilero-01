class CreateAttendances < ActiveRecord::Migration[7.0]
  def change
    create_table :attendances do |t|
      t.datetime :checked_in
      t.datetime :checked_out

      t.timestamps
    end
  end
end
