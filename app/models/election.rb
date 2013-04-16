class Election < ActiveRecord::Base
  has_many :ballots
  has_many :votes, :through => :ballots
  has_and_belongs_to_many :candidates
  accepts_nested_attributes_for :candidates
  attr_accessible :end_date, :title, :candidates_attributes
end
