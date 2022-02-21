class CreateTrainings < ActiveRecord::Migration[6.1]
  def change
    create_table :trainings do |t|
      t.datetime :date

      t.timestamps
    end
  end
end

