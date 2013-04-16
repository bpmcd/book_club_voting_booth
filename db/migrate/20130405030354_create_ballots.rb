class CreateBallots < ActiveRecord::Migration
  def change
    create_table :ballots do |t|
      t.references :user, :null => false
      t.references :election, :null => false

      t.timestamps
    end
  end
end
