class CreateElections < ActiveRecord::Migration
  def change
    create_table :elections do |t|
      t.string :title
      t.date :end_date
      t.string :winner

      t.timestamps
    end
  end
end
