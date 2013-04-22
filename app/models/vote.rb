class Vote < ActiveRecord::Base
  belongs_to :ballot
  belongs_to :candidate
  attr_accessible :rank, :candidate, :ballot
  validates :candidate_id, :uniqueness => { :scope => :ballot_id, :message => "a candidate may only be voted for once per ballot" }
  validates :rank, :uniqueness => { :scope => :ballot_id, :message => "a rank may only be used once per ballot" }
end
