class CreateLaunches < ActiveRecord::Migration[7.2]
  def change
    create_table :launches do |t|
      t.string :name
      t.string :mission
      t.string :description
      t.string :rocketname
      t.datetime :launchdate
      t.string :status
      t.string :location

      t.timestamps
    end
  end
end
