class Ballot < ActiveRecord::Base
  has_many :votes
  belongs_to :user
  belongs_to :election
  has_many :candidates, :through => :election
  validates :user_id, :uniqueness => { :scope => :election_id, :message => "a voter may only have one ballot per election" }
  attr_accessible :user, :election
end
