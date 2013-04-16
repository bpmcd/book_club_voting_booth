class CreateCandidates < ActiveRecord::Migration
  def change
    create_table :candidates do |t|
      t.string :name
      t.string :description
      t.string :info_url

      t.timestamps
    end

    create_table :candidates_elections, :id => false do |t|
      t.integer :candidate_id
      t.integer :election_id
    end
  end
end
