class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :rank, :null => false
      t.references :ballot, :null => false
      t.references :candidate, :null => false

      t.timestamps
    end
  end
end
